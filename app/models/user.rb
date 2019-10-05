class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
         :validatable

  has_one_attached :avatar
  has_many :tambos

  def display_avatar
    if avatar.attached?
      avatar
    else
      ActionController::Base.helpers.asset_path('defaut_avatar.png')
    end
  end
end
