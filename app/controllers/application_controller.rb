class ApplicationController < ActionController::Base
  before_action :for_devise_parameter, if: :devise_controller?

  private
  def for_devise_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :profile, :occupation, :position])
  end
end
