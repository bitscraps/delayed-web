require 'spec_helper'
require 'rake'


# describe "delayed:send_test_notification" do
#   before :all do
#     load File.expand_path("../../../../lib/tasks/delayed.rake", __FILE__)
#     Rake::Task.define_task(:environment)

    
#   end

#   it "sends a notification if train is delayed" do
#     Notification.create({departing_from: "Ipswich", departing_from_code: "IPS", arriving_at: "Stowmarket", arriving_at_code: "SMK", departing_time: "20:41", arrival_time: "20:52", repeating: "mon, tue, wed, thu, fri, "})
    
#     AppceleratorCloudServices.any_instance.should_receive :send_notification
#     VCR.use_cassette('check_for_delays') do
#       Rake::Task["delayed:check_for_delays"].invoke
#     end
#   end
# end

# describe "delayed:send_test_notification" do
#   before :all do
#     load File.expand_path("../../../../lib/tasks/delayed.rake", __FILE__)
#     Rake::Task.define_task(:environment)
#   end

#   it "sends a test notification" do
#     AppceleratorCloudServices.any_instance.should_receive :send_notification
#     VCR.use_cassette('send_test_notification') do
#       puts Rake::Task["delayed:send_test_notification"].invoke
#     end
#   end
# end