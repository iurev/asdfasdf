class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :comment, optional: true
end
