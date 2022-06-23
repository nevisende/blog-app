class ApplicationController < ActionController::Base
  include JsonWebToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo bio email])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name photo bio])
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
  end

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded = jwt_decode(header)
    @curr_user = User.find(decoded[:user_id])
  end
end
