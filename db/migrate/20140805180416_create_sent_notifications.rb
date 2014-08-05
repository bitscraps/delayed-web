class CreateSentNotifications < ActiveRecord::Migration
  def change
    create_table :sent_notifications do |t|
      t.string :channel
      t.string :message

      t.timestamps
    end
  end
end
