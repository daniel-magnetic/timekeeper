class AddTotalHoursToTimecard < ActiveRecord::Migration[5.0]
  def change
    add_column :timecards, :totalhours, :decimal, precision: 10, scale: 3
  end
end
