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
end
