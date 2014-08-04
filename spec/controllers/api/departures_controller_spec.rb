require 'spec_helper'


describe Api::DeparturesController do
  describe "GET" do
    it "returns JSON containing the departure requested" do
      get 'index', {"from" => "IPS", "to" => "SMK", "time" => "21:17"}
      times = JSON.parse(response.body)
      expect(times["status"]).to eq("On time")
    end
  end

end