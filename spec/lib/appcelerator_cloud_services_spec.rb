require 'spec_helper'
require_relative '../../lib/appcelerator_cloud_services.rb'

describe AppceleratorCloudServices do
  describe "new_message?" do
  	it "should return true if this message has not been sent" do
  		VCR.use_cassette('appcelerator_login') do
        @acs = AppceleratorCloudServices.new
      end

  		expect(@acs.new_message?("test", "test-channel")).to be_truthy
  	end

  	it "should return false if this message has already been sent" do
      
  		SentNotification.create(message:"test", channel:"test-channel")
  		VCR.use_cassette('appcelerator_login') do
        @acs = AppceleratorCloudServices.new
      end
  		expect(@acs.new_message?("test", "test-channel")).to be_falsy
  	end
  end
 end