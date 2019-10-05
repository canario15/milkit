class Tambo < ApplicationRecord
  belongs_to :user
  has_many :cows
  has_one_attached :logo

  validates :name, presence: true

  def to_s
    name
  end

  def display_logo
    if logo.attached?
      logo
    else
      ActionController::Base.helpers.asset_path('tambo_defaut.jpeg')
    end
  end
end
