require_relative '../timetable.rb'
require_relative '../appcelerator_cloud_services.rb'

namespace :delayed do
  desc "TODO"
  task check_for_delays: :environment do
  	weekdays = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat']
  	
  	@checks = Notification.select("DISTINCT departing_from_code, arriving_at_code, departing_time").where("(departing_time LIKE ? OR departing_time LIKE ?) AND repeating LIKE ?", "#{Time.now.hour}:%", "#{(Time.now- 1.hour).hour}:%", "%#{weekdays[Time.now.wday]}%")
  	#puts  Notification.select("DISTINCT departing_from_code, arriving_at_code, departing_time").where("(departing_time LIKE ? OR departing_time LIKE ?) AND repeating LIKE ?", "21:%", "22:%", "%#{weekdays[Time.now.wday]}%").to_sql
  	
  	@checks.each do |train|
  		@departure = Timetable.new(train.departing_from_code, train.arriving_at_code, train.departing_time)
  		if @departure.status_is_available? && @departure.is_delayed?
 			AppceleratorCloudServices::send_notification("The #{train.departing_time} from #{train.departing_from_code} to #{train.arriving_at_code} is #{@departure.get_delay_length} and is now due at #{@departure.get_new_departure_time}", "#{train.departing_from_code}-#{train.arriving_at_code}-#{train.departing_time}-#{weekdays[Time.now.wday]}")
 		end
  	end
  end
end
