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
  # validate :avatar_content_type, :avatar_size, :avatar_dimension

  # private

  # def avatar_content_type
  #   if avatar.attached? && !avatar.content_type.in?(%w(image/jpeg image/png))
  #     errors.add(:base, 'Avatar must be a JPEG or PNG image')
  #   end
  # end

  # def avatar_size
  #   if avatar.attached? && avatar.blob.byte_size > 10.megabytes
  #     errors.add(:base, 'Avatar size must be less than 10 megabytes')
  #   end
  # end

  # def avatar_dimension
  #   if avatar.attached? && avatar.variable?
  #     begin
  #       variant = avatar.variant(resize_to_limit: [1600, 1200])
  #       if variant.processed.width > 1600 || variant.processed.height > 1200
  #         errors.add(:base, 'Avatar dimensions cannot exceed 1600x1200 pixels')
  #       end
  #     rescue => e
  #       errors.add(:base, 'Error processing avatar')
  #       # Variant does not exist or encountered an error during generation
  #     end
  #   end
  # end
  
  
end
