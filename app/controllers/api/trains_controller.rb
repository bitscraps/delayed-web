class Api::TrainsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    if params["from"] && params["to"] && params["time"]
      trains = []
      puts "http://ojp.nationalrail.co.uk/service/timesandfares/#{params["from"]}/#{params["to"]}/today/#{params["time"]}/dep"
      web_page = Nokogiri::HTML(open("http://ojp.nationalrail.co.uk/service/timesandfares/#{params["from"]}/#{params["to"]}/today/#{params["time"]}/dep"))
      web_page.css('#oft tbody .mtx').each do |link|
        from = link.css('.from').text.gsub(/\n/, "").gsub(/\t/, "").gsub(/\[.*\].*/, "").lstrip.chop
        to = link.css('.to').text.gsub(/\n/, "").gsub(/\t/, "").gsub(/\[.*\].*/, "").lstrip.chop
        from_code = link.css('.from').text.match(/\[(.*?)\]/)
        from_code = $1
        to_code = link.css('.to').text.match(/\[(.*?)\]/)
        to_code = $1
        dep = link.css('.dep').text.gsub(/\n/, "").gsub(/\t/, "")
        arr = link.css('.arr').text.gsub(/\n/, "").gsub(/\t/, "")
        trains << {from: from , to: to, dep: dep, arr: arr, from_code: from_code, to_code: to_code}
      end
      render json: trains
    else 
      render json: {error: "missing some or all parameters", text: "Please ensure that you have passed the 'from', 'to' and 'time' parameters."}, status: 400
	   end
  end
end