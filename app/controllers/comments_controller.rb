class CommentsController < ApplicationController
  class CommentNode
    attr_reader :comment
    
    def initialize(comment)
      @comment = comment
      @children = []
    end

    def find_and_add!(all_comments)
      new_children = all_comments.filter { |c| c.comment_id == comment.id }
      new_children.each do |child_comment|
        cn = CommentNode.new(child_comment)
        cn.find_and_add!(all_comments)


        self.add!(cn)
      end
    end

    def add!(comment)
      @children.push comment
    end
  end

  class NestedComments
    attr_reader :tree, :article_id, :all_comments

    def initialize(article_id, all_comments: comments)
      @article_id = article_id
      @all_comments = all_comments
      @tree = []
    end

    def call
      all_comments.each do |comment|
        next if comment.comment_id
        cn = CommentNode.new(comment)
        cn.find_and_add!(all_comments)
        @tree.push cn
      end
      @tree
    end
  end

  def create
    user = User.find_by_nickname(params[:user_nickname])
    comment = Comment.create!(user: user, body: params[:body], comment_id: params[:comment_id], article_id: params[:article_id])
    render json: comment.to_json
  end

  def index
    comments = Comment.where(article_id: params[:article_id]).preload(:user)

    comments_tree = NestedComments.new(params[:article_id], all_comments: comments).call
    render json: comments_tree.to_json
  end
end
