class ChangeStatusToBeIntegerInCow < ActiveRecord::Migration[5.2]
  def up
    Cow.where.not(status: nil).update_all(status: 5)
    change_column :cows, :status, :integer, using: 'status::integer'
  end

  def down
    change_column :cows, :status, :string
  end
end
