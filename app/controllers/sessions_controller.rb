class SessionsController < ApplicationController
  def new
  end

  def create
    redirect_to root_path and return if params["error"] == ("access_denied")

    @result = params.permit(:code, :scope)
    user_info = {}
    user_info[:code] = @result[:code]
    user_info[:scope] = @result[:scope]
    user_info[:account_id] = @result[:scope].split(":")[1]

    response = HTTParty.post("https://id.getharvest.com/api/v2/oauth2/token",
                             headers: {
                               "User-Agent" => ApplicationHelper::APP_NAME,
                               "Content-Type" => "application/json",
                             },
                             body: {
                               "code": user_info[:code],
                               "client_id": ApplicationHelper::CLIENT_ID,
                               "client_secret": ApplicationHelper::CLIENT_SECRET,
                               "grant_type": "authorization_code",
                             }.to_json)

    user_info[:access_token] = response["access_token"]
    user_info[:refresh_token] = response["refresh_token"]
    user_info[:token_type] = response["token_type"]
    user_info[:expires_at] = (DateTime.now + response["expires_in"].seconds).to_s
    user_info[:headers] = {
      "Authorization" => "Bearer " + user_info[:access_token],
      "Harvest-Account-ID" => user_info[:account_id],
      "User-Agent" => ApplicationHelper::APP_NAME,
      "Content-Type" => "application/json",
    }

    http_response = HTTParty.get("https://api.harvestapp.com/api/v2/users/me", headers: user_info[:headers])
    user_info[:first_name] = http_response["first_name"]
    user_info[:last_name] = http_response["last_name"]
    user_info[:email] = http_response["email"]
    user_info[:user_id] = http_response["id"]
    user_info[:avatar_url] = http_response["avatar_url"]

    session[:user_info] = user_info.dup
    redirect_to root_path
  end

  def destroy
    session.delete(:user_info)
    redirect_to root_path
  end
end
