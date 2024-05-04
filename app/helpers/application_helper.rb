module ApplicationHelper
  CLIENT_ID     = Rails.application.credentials[:harvest][Rails.env][:client_id]
  CLIENT_SECRET = Rails.application.credentials[:harvest][Rails.env][:client_secret]
  APP_NAME      = Rails.application.credentials[:harvest][Rails.env][:app_name]
  AUTH_URL      = "https://id.getharvest.com/oauth2/authorize?client_id=" + CLIENT_ID + "&response_type=code"
end
