# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

    private

    def sign_up_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :user_type)
    end
  end
end
