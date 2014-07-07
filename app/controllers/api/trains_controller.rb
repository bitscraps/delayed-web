class Api::TrainsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    trains = []
    web_page = Nokogiri::HTML(open("http://ojp.nationalrail.co.uk/service/timesandfares/#{params[:from]}/#{params[:to]}/today/#{params[:time]}/dep"))

    web_page.css('#oft tbody .mtx').each do |link|
      from = link.css('.from').text.gsub(/\n/, "").gsub(/\t/, "").gsub(/\[.*\]/, "").gsub(/\<span.*\/span\//, "")
      to = link.css('.to').text.gsub(/\n/, "").gsub(/\t/, "").gsub(/\[.*\]/, "").gsub(/\<span.*\/span\//, "")
      dep = link.css('.dep').text.gsub(/\n/, "").gsub(/\t/, "")
      arr = link.css('.dep').text.gsub(/\n/, "").gsub(/\t/, "")
      trains << {from: from , to: to, dep: dep, arr: arr}
    end
    puts trains.inspect
    render json: {}
	end
end