class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise_modules = [:database_authenticatable, :registerable,
                    :recoverable, :rememberable, :validatable]

  devise_modules << :confirmable if Rails.env.production?

  devise *devise_modules

  before_save :sanitize_contact_number

  def full_name
    "#{first_name} #{last_name}"
  end

  def role
    is_admin ? "ADMIN" : "Normal User"
  end

  has_one_attached :avatar

  has_many :orders, dependent: :destroy
  has_many :menu_item_ratings, dependent: :destroy

  validate :avatar_image_size_under_limit

  private
  def sanitize_contact_number
    if contact_number.present?
      self.contact_number = contact_number.gsub(/[\s-]+/, '')
    end
  end

  def avatar_image_size_under_limit
    if avatar.attached? && avatar.blob.byte_size > 5.megabytes
      avatar.purge
      errors.add(:avatar, 'is too large (max is 5MB)')
    end
  end
end
