class AddTableFieldsToCow < ActiveRecord::Migration[5.2]
  def change
    add_column :cows, :due_date, :date
    add_column :cows, :service_num, :integer
    add_column :cows, :service_date, :date
    add_column :cows, :date, :date
    add_column :cows, :bull, :string
  end
end
