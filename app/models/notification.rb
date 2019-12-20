# frozen_string_literal: true

# Notification class
class Notification < ApplicationRecord
  belongs_to :tambo
  belongs_to :cow
  belongs_to :event
  belongs_to :user

  scope :unread, -> { where(read: false).order(notify_date: :desc) }
  scope :read, -> { where(read: true).order(notify_date: :desc) }
  default_scope { order(notify_date: :desc, read: :asc) }

  after_create :set_title_and_description

  private

  def set_title_and_description
    self.description = event.notify_description
    self.title = "#{tambo.name} - #{cow.caravan_with_type} - #{description}"
    save
  end
end
