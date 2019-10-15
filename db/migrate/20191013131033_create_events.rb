class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :cow, foreign_key: true
      t.date :date_event
      t.integer :action
      t.string :bull
      t.date :notification
      t.text :observations

      t.timestamps
    end
  end
end
