class AppceleratorCloudServices
	require 'typhoeus'

    def initialize
        @key = 'KVJOFzVqhJwchXFYnAT1tb0YSTGjqoPS'


        request = Typhoeus::Request.new(
            "https://api.cloud.appcelerator.com/v1/users/login.json?key=#{@key}",
            cookiefile: "/tmp/acs_cookie.txt", cookiejar: "/tmp/acs_cookie.txt",
            method: :post,
            followlocation: true,
            body: {login: 'graham.hadgraft@gmail.com', password: 'mxey5824'}
        )
        request.run
    end

    def send_notification(message, channel)
        request = Typhoeus::Request.new(
        	"https://api.cloud.appcelerator.com/v1/push_notification/notify.json?key=#{@key}&pretty_json=true",
            cookiefile: "/tmp/acs_cookie.txt", cookiejar: "/tmp/acs_cookie.txt",
        	method: :post,
        	body: {channel: channel, to_ids: "everyone", payload: message}
        )
        response = request.run
        puts request.inspect
        puts "\n\n"
        puts response.inspect
    end

    def new_message?
        true
    end

end