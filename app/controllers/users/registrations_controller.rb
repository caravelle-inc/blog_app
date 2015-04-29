class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  protect_from_forgery with: :null_session
  before_filter :configure_permitted_parameters, if: :devise_controller?


  # POST /resource
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
