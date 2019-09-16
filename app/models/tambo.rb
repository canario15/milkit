class Tambo < ApplicationRecord
  belongs_to :user
  has_one_attached :logo

  validates :name, presence: true

  def to_s
    name
  end
end
