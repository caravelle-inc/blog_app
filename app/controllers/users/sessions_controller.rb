class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
#   before_action :configure_permitted_parameters
#   protect_from_forgery with: :null_session
#   before_filter :configure_permitted_parameters, if: :devise_controller?

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  #  def destroy
     #super
   # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parjameter_sanitizer.for(:sign_in) << :attribute
  # end

   # def configure_permitted_parameters
   #    devise_parameter_sanitizer.for(:sign_up) << :name
   #    devise_parameter_sanitizer.for(:account_update) << :name
   # end
end
