class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :sanitize_contact_number

  def full_name
    "#{first_name} #{last_name}"
  end

  def role
    is_admin ? "ADMIN" : "Normal User"
  end

  has_one_attached :avatar

  private
  def sanitize_contact_number
    if contact_number.present?
      self.contact_number = contact_number.gsub(/[\s-]+/, '')
    end
  end
end
