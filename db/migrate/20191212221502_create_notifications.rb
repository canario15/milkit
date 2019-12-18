class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :tambo, foreign_key: true
      t.references :cow, foreign_key: true
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
      t.date :notify_date
      t.boolean :read
      t.text :description

      t.timestamps
    end
  end
end
