class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_seminarios

  protected

  def set_seminarios
    @anios = Sesion.pluck("date_part('year', fecha_i)").sort.reverse
    logger.debug @anios
  end

  def after_sign_in_path_for(resource)
   case resource
    when Admin
      panel_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:usuario])
  end
end
