class Borrow < ApplicationRecord
  belongs_to :user
  has_many :borrow_details, dependent: :destroy
  has_many :books, through: :borrow_details

  validates :date_borrow, presence: true
  validates :end_date_borrow, presence: true
  #validates :total_book, presence: true,
  #  numericality: {only_integer: true, greater_than: 0}

  enum status: {pending: 0, accept: 1, deny: 2}

  scope :newest, ->{order created_at: :DESC}

  def total_book
    borrow_details.map{|rd| rd.valid? ? rd.number : 0}.sum
  end

  def set_day
    self.date_borrow = Time.current.in_time_zone("Hanoi")
    self.end_date_borrow = from_day + 7.days
  end
end
