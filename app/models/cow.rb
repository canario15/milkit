class Cow < ApplicationRecord
  belongs_to :tambo

  validates :cow_type, presence: true
  validates :caravan, presence: true
  validates :tambo_id, presence: true

  default_scope { order(caravan: :asc) }
end
