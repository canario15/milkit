class ChangeColumnNameNotificationEvent < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :notification, :notify_date
  end
end
