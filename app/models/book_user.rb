class BookUser < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validate :check_issued

  private
  def check_issued
    if user.issued_books.include?(book)
      errors.add(:base, "Already issued")
    end
  end
end
