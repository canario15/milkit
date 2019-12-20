# frozen_string_literal: true

json.array!(@all_notifications_unread) do |notification|
  json.extract! notification, :id, :description, :title
  json.start notification.notify_date
  json.end notification.notify_date
  json.url notification_url(notification, format: :html)
end
