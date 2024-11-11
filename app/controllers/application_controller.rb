class ApplicationController < ActionController::Base
  helper_method :current_admin

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def authorize_admin
    redirect_to admin_login_path, alert: 'Not authorized' if current_admin.nil?
  end
end