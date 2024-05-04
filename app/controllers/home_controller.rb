class HomeController < ApplicationController
  def show
    redirect_to sign_in_path and return if @current_user.nil?
    http_response = HTTParty.get("https://api.harvestapp.com/v2/time_entries", headers: @current_user[:headers])
    @entries = http_response["time_entries"].take(20)
  end
end
