require 'spec_helper'


describe Api::DeparturesController do
  describe "GET" do
    it "returns JSON containing the departure requested" do
      get 'index', {"from" => "SMK", "to" => "IPS", "time" => "13:14"}
      times = JSON.parse(response.body)
      expect(times["status"]).to eq("13:16")
    end
  end

end