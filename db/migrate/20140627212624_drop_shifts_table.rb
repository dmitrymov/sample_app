class DropShiftsTable < ActiveRecord::Migration
  def change
    drop_table :shifts
  end
end
