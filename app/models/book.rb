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
end
