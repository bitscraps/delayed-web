require 'spec_helper'


describe Api::TrainsController do
  describe "GET" do
    it "returns ok" do
      get 'index'
      expect(response).to be_ok
    end
  end

end