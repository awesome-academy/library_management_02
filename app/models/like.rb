class Like < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :liked_by, ->(user_id){where user_id: user_id}
end
