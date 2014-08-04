require_relative '../timetable.rb'
require_relative '../appcelerator_cloud_services.rb'

namespace :delayed do
  desc "TODO"
  task check_for_delays: :environment do
  	@checks = Notification.select("DISTINCT departing_from_code, arriving_at_code, departing_time").where("departing_time LIKE ? OR departing_time LIKE ?", "#{Time.now.hour}:%", "#{(Time.now- 1.hour).hour}:%")
  	puts  Notification.select("DISTINCT departing_from_code, arriving_at_code, departing_time").where("departing_time LIKE ? OR departing_time LIKE ?", "21:%", "22:%").to_sql
  	
  	@checks.each do |train|
  		@departure = Timetable.new(train.departing_from_code, train.arriving_at_code, train.departing_time)
  		if @departure.status_is_available? && @departure.is_delayed?
 			AppceleratorCloudServices::send_notification("The #{train.departing_time} from #{train.departing_from_code} to #{train.arriving_at_code} is #{@departure.get_delay_length} and is now due at #{@departure.get_new_departure_time}")
 		end
  	end
  end
end
