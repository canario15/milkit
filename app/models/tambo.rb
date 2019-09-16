class Tambo < ApplicationRecord
  belongs_to :user
  has_one_attached :logo

  validates :name, presence: true

  def to_s
    name
  end

  def display_logo
    if logo.attached?
      logo
    else
      '/assets/tambo_default.jpeg'
    end
  end
end
