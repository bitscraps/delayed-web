class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :departing_from
      t.string :departing_from_code
      t.string :arriving_at
      t.string :arriving_at_code
      t.string :departing_time
      t.string :arriving_at
      t.string :repeating
      t.string :device

      t.timestamps
    end
  end
end
