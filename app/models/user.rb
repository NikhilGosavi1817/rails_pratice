class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 18 }
  validates :date_of_birth, presence: true
  validate :date_of_birth_cannot_be_in_future
  def date_of_birth_cannot_be_in_future
    return unless date_of_birth.present?
    if date_of_birth > Date.today
      errors.add(:date_of_birth, "cannot be in future")
    end
  end

  has_one_attached :avatar
  has_many :books
  enum role_type: {student: 2, librarian: 1}
  enum status: {active: 1, suspended: 2}
  include AASM
  aasm column: 'status' do
    state :active, initial:  true
    state :suspended
    
    event :suspend do
      transitions from: :active, to: :suspended
    end

    event :reactivate do
      transitions from: :suspended, to: :active
    end
  end
  # validates :avatar,  content_type: ['image/png', 'image/jpeg'],
  # dimension: { width: { max:1600 }, height: { max:1200 }, message: 'does not fit dimensions' },
  # size: { less_than: 10.megabytes , message: 'is too large' }
  # validate :avatar_content_type, :avatar_size, :avatar_dimension

  has_many :book_users
  has_many :issued_books, through: :book_users, source: :book
  
  
end
