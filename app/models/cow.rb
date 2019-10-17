class Cow < ApplicationRecord

  # Green  #0FA20B
  # Blue   #221D8F
  # Red    #ED2F15
  # Yellow #EDE515
  # Black  #010101
  # Pink   #BD12B3
  enum status: { dry: 1,
                 pregnant: 2,
                 discard: 3,
                 empty: 4,
                 dead: 5,
                 served: 6 }

  enum cow_type: { cow: 1,
                   small_cow: 2,
                   small_cow_tambo: 3 }

  belongs_to :tambo
  has_many :events

  validates :cow_type, presence: true
  validates :caravan, presence: true
  validates :tambo_id, presence: true
  validates :status, presence: true
  validates_uniqueness_of :caravan, scope: :tambo_id

  default_scope { where.not(status: :dead).order(caravan: :asc) }
  scope :no_dry, -> { where.not(status: :dry) }
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

  def self.cow_type_attributes_for_select
    cow_types.map do |cow_type, _|
      [I18n.t("activerecord.attributes.cow.cow_types.#{cow_type}"),
       cow_type]
    end
  end

  def cow_type_number
    read_attribute_before_type_cast(:cow_type)
  end

  def cow_type_name
    I18n.t("activerecord.attributes.cow.cow_types.#{cow_type}")
  end

  def caravan_with_type
    if cow_type_number == 3
      "#{caravan}VQ"
    else
      caravan
    end
  end
end
