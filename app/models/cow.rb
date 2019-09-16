class Cow < ApplicationRecord
  belongs_to :tambo
  validates :caravan, presence: true

  default_scope { order(caravan: :asc) }
end
