class AddNotifyDescriptionColumnToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :notify_description, :text
  end
end
