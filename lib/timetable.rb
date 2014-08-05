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

        @web_page.inspect
	end

	def status_is_available?
		!@service_status.nil?
	end

  def get_service_status
    status = '--:--'
    if status_is_available?
      if @service_status =~ /(..:..)(..:..)  (.*)/m
        status = get_new_departure_time
      elsif @service_status =~ /On Time/i
        status = @service_status
      else
        status = @service_status.gsub!(/..:../, '').chop
      end
    else
      status = "--:--"
    end

    status
  end

  def is_delayed?
    if status_is_available?
        @service_status.upcase != "ON TIME"
    end
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
  	@service_status =~ /(..:..)(..:..)  (.*)/m
  	delay = $3
  end

end