class Cow < ApplicationRecord
  belongs_to :tambo

  validates :cow_type, presence: true
  validates :caravan, presence: true
  validates :tambo_id, presence: true
  validate :unique_caravan_in_tambo

  default_scope { order(caravan: :asc) }

  scope :vacas, -> { where(cow_type: 1) }
  scope :vaquillonas, -> { where(cow_type: 2) }

  private
    def unique_caravan_in_tambo
      cows = Tambo.find(tambo_id).cows.where(caravan: caravan).count
      errors.add(:caravan, 'ya existe esa caravan en el tambo') if cows > 0
    end
end
