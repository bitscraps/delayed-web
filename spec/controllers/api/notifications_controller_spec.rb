require 'spec_helper'


describe Api::NotificationsController do
  describe "POST" do
    it "saves a notification" do
      post 'index', {"from_code" => "IPS", "to_code" => "SMK", "departing_at" => "23:45", "arriving_at" => "23:55", "from" => "Ipswich", "to" => "Stowmarket", "repeating" => "Monday, Tuesday, Wednesday, Thursday, Friday", "device" => "device_token"}
      times = JSON.parse(response.body)
      expect(times["status"]).to eq("Saved")
      expect(Notification.all.size).to eq 1
    end
  end

end