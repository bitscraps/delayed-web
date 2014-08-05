require 'spec_helper'
require_relative '../../lib/appcelerator_cloud_services.rb'

describe AppceleratorCloudServices do
  describe "new_message?" do
  	it "should return true if this message has not been sent" do
  		AppceleratorCloudServices.any_instance.stub(:initialize).and_return(true)

  		@acs = AppceleratorCloudServices.new
		
  		expect(@acs.new_message?("test", "test-channel")).to be_truthy
  	end

  	it "should return false if this message has already been sent" do
  		AppceleratorCloudServices.any_instance.stub(:initialize).and_return(true)
  		SentNotification.create(message:"test", channel:"test-channel")
  		@acs = AppceleratorCloudServices.new
		
  		expect(@acs.new_message?("test", "test-channel")).to be_falsy
  	end
  end
 end