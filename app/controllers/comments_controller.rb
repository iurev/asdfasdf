class CommentsController < ApplicationController
  def create
    user = User.find_by_nickname(params[:user_nickname])
    comment = Comment.create!(user: user, body: params[:body], comment_id: params[:comment_id], article_id: params[:article_id])
    render json: comment.to_json
  end
end
