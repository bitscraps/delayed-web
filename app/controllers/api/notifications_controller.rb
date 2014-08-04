class Api::NotificationsController < ApplicationController

  def index

    notification = Notification.new(
      departing_from: params[:from],
      departing_from_code: params[:from_code],
      arriving_at: params[:to],
      arriving_at_code: params[:to_code],
      departing_time: params[:departing_at],
      arrival_time: params[:arriving_at],
      repeating: params[:repeating],
      device: params[:device]

    )

    if notification.save
      response = {:status => "Saved"}
    else
      response = {:status => "unable to save"}
    end

    render json: response
  end
end