require 'spec_helper'


describe Api::NotificationsController do
  describe "POST" do
    it "saves a notification" do
      post 'create', {"from_code" => "IPS", "to_code" => "SMK", "departing_at" => "23:45", "arriving_at" => "23:55", "from" => "Ipswich", "to" => "Stowmarket", "repeating" => "Monday, Tuesday, Wednesday, Thursday, Friday", "device" => "device_token"}
      times = JSON.parse(response.body)
      expect(times["status"]).to eq("Saved")
      expect(Notification.all.size).to eq 1
    end
  end

  describe "DELETE" do
  	it "destroys a matching notification" do
  	  Notification.create(departing_from: "Ipswich", departing_from_code: "IPS", arriving_at: "Stowmarket", arriving_at_code: "SMK", departing_time: "15:45", repeating: "mon, tue, wed, thu, fri, ", device: "device_token")
  	  Notification.create(departing_from: "Ipswich", departing_from_code: "IPS", arriving_at: "Stowmarket", arriving_at_code: "SMK", departing_time: "15:45", repeating: "mon, tue, wed, ", device: "device_token")
  	  Notification.create(departing_from: "Ipswich", departing_from_code: "IPS", arriving_at: "Stowmarket", arriving_at_code: "SMK", departing_time: "15:45", repeating: "mon, tue, wed, thu, fri, ", device: "test")

  	  delete :destroy, {id: 1, "from_code" => "IPS", "to_code" => "SMK", "departing_at" => "15:45", "repeating" => "mon, tue, wed, thu, fri, ", "device" => "device_token"}
      expect(Notification.all.size).to eq 2
  	end
  end

end