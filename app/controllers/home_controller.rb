class HomeController < ApplicationController
  def show
    redirect_to sign_in_path and return if @current_user.nil?
  end
end
