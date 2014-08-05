class Timetable
  require 'nokogiri'
  require 'open-uri'

	def initialize(departing, arriving, departure_time)
      	web_page = Nokogiri::HTML(open("http://ojp.nationalrail.co.uk/service/ldbboard/dep/#{departing}/#{arriving}/To"))

      	web_page.css('.tbl-cont table tbody tr').each do |link|
        	if link.css('td:first-child').text.gsub(/\:/, '') == departure_time.gsub(/\:/, '')
        	  @service_status = link.css('.status').text
        	end
      	end
	end

	def status_is_available?
		!@service_status.nil?
	end

  def get_service_status
    if status_is_available?
      if is_delayed?
        get_new_departure_time
      else
        "ON TIME"
      end
    else
      "--:--"
    end
  end

  def is_delayed?
      @service_status.upcase != "ON TIME"
  end

  def get_original_departure_time
  	@service_status =~ /(..:..)/
   	$1
  end

  def get_new_departure_time
  	@service_status =~ /(..:..)(..:..)/
  	$2
  end

  def get_delay_length
  	@service_status =~ /(..:..)(..:..)  (.*)/
  	$3
  end

end