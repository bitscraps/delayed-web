class AddArrivingAtToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :arrival_time, :string
  end
end
