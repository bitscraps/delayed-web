class Api::DeparturesController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    if params["from"] && params["to"] && params["time"]
      trains = "--:--"
      web_page = Nokogiri::HTML(open("http://ojp.nationalrail.co.uk/service/ldbboard/dep/#{params[:from]}/#{params[:to]}/To"))
     
      web_page.css('.tbl-cont table tbody tr').each do |link|
        if link.css('td:first-child').text.gsub(/\:/, '') == params[:time].gsub(/\:/, '')
          trains = link.css('.status').text
        end
      end
      render json: trains
    else 
      render json: {error: "missing some or all parameters", text: "Please ensure that you have passed the 'from', 'to' and 'time' parameters."}, status: 400
	   end
  end
end