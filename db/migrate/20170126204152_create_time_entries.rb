class CreateTimeEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :time_entries do |t|
      t.references :timecard, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end
