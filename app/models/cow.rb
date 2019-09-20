class Cow < ApplicationRecord
  belongs_to :tambo

  validates :cow_type, presence: true
  validates :caravan, presence: true
  validates :tambo_id, presence: true

  default_scope { order(caravan: :asc) }

  scope :vacas, -> { where(cow_type: 1) }
  scope :vaquillonas, -> { where(cow_type: 2) }
end
