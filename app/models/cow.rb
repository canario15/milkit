class Cow < ApplicationRecord

  # Green  #0FA20B
  # Blue   #221D8F
  # Red    #ED2F15
  # Yellow #EDE515
  # Black  #010101
  # Pink   #BD12B3
  enum status: { dry: 1, pregnant: 2, discard: 3, empty: 4, dead: 5, served: 6 }

  belongs_to :tambo
  has_many :events

  validates :cow_type, presence: true
  validates :caravan, presence: true
  validates :tambo_id, presence: true
  validates :status, presence: true
  validates_uniqueness_of :caravan, scope: :tambo_id

  default_scope { where.not(status: :dead).order(caravan: :asc) }
  scope :no_empty, -> { where.not(status: :empty) }
  scope :vacas, -> { where(cow_type: [1, 3]) }
  scope :vaquillonas, -> { where(cow_type: 2) }

  def self.status_attributes_for_select
    statuses.map do |status, _|
      [I18n.t("activerecord.attributes.cow.statuses.#{status}"),
       status]
    end
  end

  def status_number
    read_attribute_before_type_cast(:status)
  end

  def status_name
    I18n.t("activerecord.attributes.cow.statuses.#{status}")
  end

  def caravan
    if cow_type == 3
      "#{self[:caravan]}-VQ"
    else
      self[:caravan]
    end
  end
end
