class Cow < ApplicationRecord
  belongs_to :tambo

  validates :caravan, presence: true
  validates :tambo_id, presence: true

  default_scope { order(caravan: :asc) }
end
