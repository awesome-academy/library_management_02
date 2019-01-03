class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :borrows, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :follows, dependent: :destroy

  validates :full_name, presence: true, length: { maximum: Settings.user.name_maximum }
  validates :address, presence: true, length: { maximum: Settings.user.address_maximum }
  validates :phone_number, presence: true, length: { maximum: Settings.user.phone_maximum }
  validates :email, presence: true, length: { maximum: Settings.user.email_maximum },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: Settings.user.pass_minimum }

  has_secure_password

  enum role: {user: 0, admin: 1}

  scope :newest, ->{order created_at: :DESC}
end