class Relationship < ActiveRecord::Base
  #Two different relations with different names to the same model
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  
  #follow(), unfollow(), and following?() are defined in the User model
  
end
