# frozen_string_literal: true

# Event class
class Event < ApplicationRecord
  enum action: { served: 1,
                 pregnant: 2,
                 dry: 3,
                 gave_birth: 4,
                 empty: 5 }

  belongs_to :cow

  validates :date_event, presence: true
  validates :action, presence: true

  default_scope { order(date_event: :asc) }

  after_save :update_cow_data
  after_destroy :set_cow_status

  def self.action_attributes_for_select
    actions.map do |action, _|
      [I18n.t("activerecord.attributes.event.actions.#{action}"),
       action]
    end
  end

  def action_number
    read_attribute_before_type_cast(:action)
  end

  def action_name
    I18n.t("activerecord.attributes.event.actions.#{action}")
  end

  def self.updte_all_data
    Cow.all.each do |cow|
      cow.due_date = cow.events.gave_birth.try(:last).try(:date_event)
      cow.service_num = cow.events.served.try(:count)
      cow.service_date = cow.events.served.try(:last).try(:date_event)
      cow.save
    end
  end

  private

  def update_cow_data
    cow.status = set_cow_status
    cow.due_date = cow.last_due_date
    cow.service_num = cow.count_served_after_gave_birth
    cow.service_date = cow.last_service_date
    cow.save
  end

  def set_cow_status
    case cow.events.last.action_number
    when 1 then 6
    when 2 then 2
    when 3 then 1
    when 4 then 4
    when 5 then 4
    else
      1
    end
  end
end
