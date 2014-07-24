require 'spec_helper'


describe Api::DeparturesController do
  describe "GET" do
    it "returns JSON containing the departure requested" do
      get 'index', {"from" => "IPS", "to" => "SMK", "time" => "23:45"}
      times = response.body
      expect(times).to eq("On time")
    end
  end

end