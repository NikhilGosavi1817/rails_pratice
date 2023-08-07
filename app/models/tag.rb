class Tag < ApplicationRecord
    has_many :book_tags
    has_many :books, through: :book_tags

    validates :name, presence: true, uniqueness: true

  before_destroy :check_for_books

  private

  def check_for_books
    return false if books.any?
  end
end
