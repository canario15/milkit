class Event < ApplicationRecord

  enum action: { served: 1,
                 pregnant: 2,
                 dry: 3,
                 gave_birth: 4,
                 empty: 5,
                 inseminate: 6 }

  belongs_to :cow

  validates :date_event, presence: true
  validates :action, presence: true

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
end
