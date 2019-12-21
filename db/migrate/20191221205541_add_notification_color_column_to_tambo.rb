class AddNotificationColorColumnToTambo < ActiveRecord::Migration[5.2]
  def change
    add_column :tambos, :notification_color, :string
  end
end
