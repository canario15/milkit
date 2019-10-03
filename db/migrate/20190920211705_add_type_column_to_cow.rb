class AddTypeColumnToCow < ActiveRecord::Migration[5.2]
  def change
    add_column :cows, :cow_type, :integer
  end
end
