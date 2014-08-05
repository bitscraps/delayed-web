require 'spec_helper'


describe Api::DeparturesController do
  describe "GET" do
    it "returns JSON containing the departure requested" do
      Timetable.any_instance.stub(:get_service_status).and_return("--:--")

      VCR.use_cassette('past_train') do
        get 'index', {"from" => "SMK", "to" => "IPS", "time" => "13:14"}
      end
      times = JSON.parse(response.body)

      expect(times["status"]).to eq("--:--")
    end
  end

end