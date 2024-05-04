class ApplicationController < ActionController::Base
  include ActionController::Cookies

  before_action :clear_sessions
  before_action :load_user_info

  private

  SESSION_MAX = 20

  def clear_sessions
    # Delete all sessions
    # ActiveRecord::Base.connection.exec_delete("DELETE FROM sessions"); return

    # Delete sessions older than an hour
    # ActiveRecord::Base.connection.exec_delete("DELETE FROM sessions WHERE created_at < '#{(DateTime.current - 1.hour).to_fs(:db)}'"); return

    # Keep the last SESSION_MAX sessions in memory
    nb_of_sessions = ActiveRecord::Base.connection.exec_query("SELECT COUNT(id) FROM sessions").first.first.last
    return if nb_of_sessions < SESSION_MAX
    id = ActiveRecord::Base.connection.exec_query("SELECT id FROM sessions ORDER BY created_at DESC LIMIT #{SESSION_MAX}").rows.last.first
    ActiveRecord::Base.connection.exec_delete("DELETE FROM sessions WHERE id < #{id}")
  end

  def load_user_info
    if session[:user_info].nil? && params[:controller] != "sessions"
      redirect_to sign_in_path
      return
    end
    @current_user = session[:user_info]
  end
end
