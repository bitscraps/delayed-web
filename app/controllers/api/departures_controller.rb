class Api::DeparturesController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require_relative '../../../lib/timetable.rb'

  def index
    if params["from"] && params["to"] && params["time"]
      @timetable = Timetable.new(params["from"], params["to"], params["time"])

      render json: {status: @timetable.get_service_status}
    else
      render json: {error: "missing some or all parameters", text: "Please ensure that you have passed the 'from', 'to' and 'time' parameters."}, status: 400
	   end
  end
end