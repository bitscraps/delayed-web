class AppceleratorCloudServices
	require 'typhoeus'

    def initialize
        @key = 'KVJOFzVqhJwchXFYnAT1tb0YSTGjqoPS'


        request = Typhoeus::Request.new(
            "https://api.cloud.appcelerator.com/v1/users/login.json?key=#{@key}",
            cookiefile: "/tmp/acs_cookie.txt", cookiejar: "/tmp/acs_cookie.txt",
            method: :post,
            followlocation: true,
            body: {login: 'graham.hadgraft@gmail.com', password: 'tu7cw3ba'}
        )
        request.run
    end

    def send_notification(message, channel)
        request = Typhoeus::Request.new(
        	"https://api.cloud.appcelerator.com/v1/push_notification/notify.json?key=#{@key}&pretty_json=true",
            cookiefile: "/tmp/acs_cookie.txt", cookiejar: "/tmp/acs_cookie.txt",
        	method: :post,
        	body: {channel: channel, to_ids: "everyone", payload: {"alert" => message, "sound" => "default"}}
        )
        SentNotification.create(message:message, channel: channel)
        response = request.run
        puts request.inspect
        puts "\n\n"
        puts response.inspect
    end

    def new_message?(message, channel)
        notification = SentNotification.where("message = ? AND channel = ? AND created_at > ?", message, channel, Time.now-2.hours)
        notification.size == 0
    end

end
