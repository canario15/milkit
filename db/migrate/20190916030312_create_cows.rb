class CreateCows < ActiveRecord::Migration[5.2]
  def change
    create_table :cows do |t|
      t.string :caravan
      t.date :birth_date
      t.string :status
      t.references :tambo, foreign_key: true

      t.timestamps
    end
  end
end
