class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def full_name
    "#{first_name} #{last_name}"
  end

  def role
    is_admin ? "ADMIN" : "Normal User"
  end

  has_one_attached :avatar

  # has_many :menu_items, dependent: :destroy


  # phony_normalize :contact_number, default_country_code: 'BD'
  # validates :contact_number, phony_plausible: true
end
