class Connection < ApplicationRecord
  validates :user_id, :friend_id, presence: false
  validates :friender_id, uniqueness: { scope: :friendee_id, message: "is already friends with this user" }
  validates :friendee_id, uniqueness: { scope: :friender_id, message: "is already friends with this user" }

  belongs_to :friender, class_name: "User"
  belongs_to :friendee, class_name: "User"
end
