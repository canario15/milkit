# frozen_string_literal: true

# Cow class
class Cow < ApplicationRecord
  enum status: { dry: 1,      # Green  #0FA20B
                 pregnant: 2, # Blue   #221D8F
                 discard: 3,  # Red    #ED2F15
                 empty: 4,    # Yellow #EDE515
                 dead: 5,     # Black  #010101
                 served: 6 }  # Pink   #BD12B3

  enum cow_type: { cow: 1,
                   small_cow: 2,
                   small_cow_tambo: 3 }

  belongs_to :tambo
  has_many :events

  validates :cow_type, presence: true
  validates :caravan, presence: true, numericality: { only_integer: true }
  validates :tambo_id, presence: true
  validates :status, presence: true
  validates_uniqueness_of :caravan, scope: :tambo_id

  default_scope do
    where.not(status: :dead)
         .order('caravan::integer ASC')
  end
  scope :no_dry, -> { where.not(status: :dry) }
  scope :vacas, -> { where(cow_type: [1, 3]) }
  scope :vaquillonas, -> { where(cow_type: 2) }

  def self.status_attributes_for_select
    statuses.map do |status, _|
      [I18n.t("activerecord.attributes.cow.statuses.#{status}"),
       status]
    end
  end

  def self.cow_type_attributes_for_select
    cow_types.map do |cow_type, _|
      [I18n.t("activerecord.attributes.cow.cow_types.#{cow_type}"),
       cow_type]
    end
  end

  def status_number
    read_attribute_before_type_cast(:status)
  end

  def status_name
    I18n.t("activerecord.attributes.cow.statuses.#{status}")
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

  def last_due_date
    events.gave_birth.try(:last).try(:date_event)
  end

  def count_served_after_gave_birth
    events.served.where('date_event >= ?', last_due_date).count
  end

  def last_service_date
    events.served.where('date_event >= ?', last_due_date).last.try(:date_event)
  end

  # Temporal method
  def self.create_served_event
    pregnant.each do |cow|
      next unless cow.events.served.blank?

      event_id = cow.events.pregnant.last.id
      pregnant_date = cow.events.pregnant.last.date_event
      Event.create(cow_id: cow.id, date_event: pregnant_date, action: 1)
      Event.create(cow_id: cow.id,
                   date_event: pregnant_date,
                   action: 2,
                   notify_date: pregnant_date + 190.days,
                   notify_description: 'Revisar para secar')
      Event.find(event_id).destroy
    end
  end
end
