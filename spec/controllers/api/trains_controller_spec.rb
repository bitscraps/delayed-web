require 'spec_helper'


describe Api::TrainsController do
  describe "GET" do
    it "returns a json array of trains" do
      VCR.use_cassette('trains_timetable') do
        get 'index', {"from" => "IPS", "to" => "SMK", "time" => "0830"}
      end
      times = JSON.parse(response.body)
      expect(times.first["dep"]).to eq("08:44")
      expect(times.first["to_code"]).to eq("SMK")
      expect(times.first["from"]).to eq("Ipswich ")
      expect(times.first["from_code"]).to eq("IPS")
      expect(times.first["to"]).to eq("Stowmarket ")
      expect(times.first["arr"]).to eq("08:55")
    end

    it "returns error if not passed all params" do
      get 'index'
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)["error"]).to eq("missing some or all parameters")
    end
  end

end