class Users::RegistrationsController < Devise::RegistrationsController

  protect_from_forgery with: :null_session
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def create
    super
    @email = sign_up_params[:email]
    UserMailer.registration_confirmation(@email).deliver unless resource.invalid?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :email]
    devise_parameter_sanitizer.for(:account_update) << [:name, :image]
  end

end
