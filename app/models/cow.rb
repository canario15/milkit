class Cow < ApplicationRecord
  belongs_to :tambo
  validates :caravan, presence: true
end
