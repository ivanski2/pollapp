class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_admin

  def current_admin
    current_user if current_user&.admin
  end

  protected

  def configure_permitted_parameters
    Rails.logger.info "Permitting parameters for sign_up and account_update."
    devise_parameter_sanitizer.permit(:sign_up, keys: [:admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:admin])
  end

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_polls_path : root_path
  end
end