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
      'tambo_defaut.png'
    end
  end
end
