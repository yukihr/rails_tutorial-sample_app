class Comment < ActiveRecord::Base
  attr_accessible :content, :micropost_id
  belongs_to :user
  belongs_to :micropost

  validates :content, presence: true, length: { maximum: 140 } 
  validates :micropost_id, presence: true
  validates :user_id, presence: true
end
