class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
         :validatable

  has_one_attached :avatar
  has_many :tambos
  has_many :notifications

  def display_avatar
    if avatar.attached?
      avatar
    else
      'defaut_avatar.png'
    end
  end

  def today_notification
    notifications.where(read: false).where('notify_date <= ?', Date.today)
  end
end
