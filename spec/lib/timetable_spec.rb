require 'spec_helper'
require_relative '../../lib/timetable.rb'

describe Timetable do
  describe "status_is_available?" do
    it "returns true if the live departure board has info on this service" do
      VCR.use_cassette('current_train') do
        @timetable = Timetable.new("SMK", "IPS", "1545")
      end

      expect(@timetable.status_is_available?).to be_truthy
    end

    it "returns false if the live departure board has no info on this service" do
      VCR.use_cassette('past_train') do
        @timetable = Timetable.new("SMK", "IPS", "1814")
      end

      expect(@timetable.status_is_available?).to be_falsy
    end
  end

  describe "is_delayed?" do
    it "returns true if the train is late" do
      VCR.use_cassette('late_train') do
        @timetable = Timetable.new("MAN", "LIV", "1537")
      end

      expect(@timetable.is_delayed?).to be_truthy
    end

    it "returns false if the train is not delayed" do
      VCR.use_cassette('current_train') do
        @timetable = Timetable.new("SMK", "IPS", "1545")
      end

      expect(@timetable.is_delayed?).to be_falsey
    end
  end

  describe "get_original_departure_time" do
    it "returns the original departure time" do
      VCR.use_cassette('late_train') do
        @timetable = Timetable.new("MAN", "LIV", "1537")
      end

      expect(@timetable.get_original_departure_time).to eq "15:37"
    end
  end

  describe "get_new_departure_time" do
    it "returns the new departure time" do
      VCR.use_cassette('late_train') do
        @timetable = Timetable.new("MAN", "LIV", "1537")
      end

      expect(@timetable.get_new_departure_time).to eq "15:44"
    end
  end

  describe "get_delay_length" do
    it "returns the time the train is delayed for" do
      VCR.use_cassette('late_train') do
        @timetable = Timetable.new("MAN", "LIV", "1537")
      end

      expect(@timetable.get_delay_length).to eq "7 mins late"
    end
  end

  describe "get_service_status" do
    it "returns delayed when delayed" do
      VCR.use_cassette('delayed') do
        @timetable = Timetable.new("MAN", "MIA", "1624")
      end

      expect(@timetable.get_service_status).to eq "Delayed"
    end
    it "returns cancelled when cancelled" do
      VCR.use_cassette('cancelled') do
        @timetable = Timetable.new("MAN", "MIA", "1624")
      end

      expect(@timetable.get_service_status).to eq "Cancelled"
    end
    it "returns --:-- when not available" do
      VCR.use_cassette('past_train') do
        @timetable = Timetable.new("SMK", "IPS", "1814")
      end

      expect(@timetable.get_service_status).to eq "--:--"
    end

     it "returns the new departure time when available" do
      VCR.use_cassette('late_train') do
        @timetable = Timetable.new("MAN", "LIV", "1537")
      end

      expect(@timetable.get_service_status).to eq "15:44"
    end
  end

end