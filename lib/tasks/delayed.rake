require_relative '../timetable.rb'
require_relative '../appcelerator_cloud_services.rb'

namespace :delayed do
  desc "TODO"
  task check_for_delays: :environment do
  	weekdays = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat']

  	@checks = Notification.select("DISTINCT departing_from_code, arriving_at_code, departing_time").where("(departing_time LIKE ? OR departing_time LIKE ?) AND repeating LIKE ?", "#{Time.now.hour}:%", "#{(Time.now+1.hour).hour}:%", "%#{weekdays[Time.now.wday]}%")
  	puts  Notification.select("DISTINCT departing_from_code, arriving_at_code, departing_time").where("(departing_time LIKE ? OR departing_time LIKE ?) AND repeating LIKE ?", "#{Time.now.hour}:%", "#{(Time.now+1.hour).hour}:%", "%#{weekdays[Time.now.wday]}%").to_sql

    @acs = AppceleratorCloudServices.new

  	@checks.each do |train|
      puts train.inspect
  		@departure = Timetable.new(train.departing_from_code, train.arriving_at_code, train.departing_time)
  		if @departure.status_is_available? && @departure.is_delayed?
        message = "The #{train.departing_time} from #{train.departing_from_code} to #{train.arriving_at_code} is #{@departure.get_delay_length} and is now due at #{@departure.get_new_departure_time}"
 			  channel = "#{train.departing_from_code}-#{train.arriving_at_code}-#{train.departing_time}-#{weekdays[Time.now.wday]}"

        @acs.send_notification(message, channel) if @acs.new_message?
 		end
  	end
  end

  task send_test_notification: :environment do
    @acs = AppceleratorCloudServices.new

    @acs.send_notification("Test Notification","news_alerts")

  end
end
