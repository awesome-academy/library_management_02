class Book < ApplicationRecord
  VALID_NUMBER_REGEX = /\A\d+\z/i

  has_many :likes, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :borrow_details, dependent: :destroy
  belongs_to :publisher
  belongs_to :category
  belongs_to :author

  validates :name, presence: true,
    length: { maximum: Settings.book.name_maximum }
  validates :num_of_pages, presence: true,
    length: {minimum: Settings.book.number.min_length}
  validates :image, presence: true
  validates :amount, format: { with: VALID_NUMBER_REGEX},
    length: {minimum: Settings.book.number.min_length}
  validate  :picture_size

  scope :alphabet, ->{order name: :ASC}
  scope :_page,->(page){paginate page: page, per_page: Settings.paginate.per_page}
  scope :search_book, -> search {
    where("books.name LIKE ?", "%#{search.strip}%") if search.present?
  }

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
