class AppceleratorCloudServices
	require 'typhoeus'

    def self.send_notification(message, channel)
    	@key = 'KVJOFzVqhJwchXFYnAT1tb0YSTGjqoPS'
        puts message

        request = Typhoeus::Request.new(
        	"https://api.cloud.appcelerator.com/v1/push_notification/notify.json?key=#{@key}&pretty_json=true",
        	method: :post,
        	params: {channel: channel, to_ids: "everyone"}
        )
        response = request.run
        puts request.inspect
        puts response
    end

end