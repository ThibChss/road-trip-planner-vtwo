# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      profile_path(resource)
    else
      super
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def new
    if request.headers['Turbo-Frame']
      super
    else
      redirect_to connect_path, alert: "Cannot find this page"
    end
  end

  def create
    # auth_options = { recall: nil, scope: :user }
    self.resource = warden.authenticate!(auth_options)

    if resource
      sign_in(resource_name, resource)
      redirect_to after_sign_in_path_for(resource), notice: "Hello #{resource.first_name}! 👋🏻"
    else
      respond_to do |format|
        format.html { render 'pages/connect', layout: false }
        format.turbo_stream { flash.now[:alert] = 'Invalid email or password' }
      end
    end
  end
end
