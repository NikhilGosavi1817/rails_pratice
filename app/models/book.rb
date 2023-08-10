class Book < ApplicationRecord
    belongs_to :user
    include AASM

    aasm column: 'status' do
        state :available, initial: true
        state :not_unavailable
        state :archived
    end

    validates :name, presence: true
    validates :description, presence: true
    validates :number_of_copy, presence:  true

    has_many :book_tags
    has_many :tags, through: :book_tags

    before_destroy :check_for_books
    private

    def check_for_books
      return false if books.any?
    end

    has_many :book_users
    has_many :students, through: :book_users, source: :user
end
