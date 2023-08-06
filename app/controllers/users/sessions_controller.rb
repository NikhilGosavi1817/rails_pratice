# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  # binding.pry
  #   super
  # end

  # POST /resource/sign_in
  def create
    # binding.pry
    if current_user.present?
      if request.path=="/users/sign_in"
        if current_user.librarian?
          super
        else
          flash[:notice]="Unauthorized access"
          sign_out current_user
          redirect_to root_path
        end
      elsif request.path=="/student/sign_in"
        if current_user.student? && current_user.active?
          super
        elsif current_user.student? && current_user.suspended?
          flash[:notice]="Account suspended"
          sign_out current_user
          redirect_to root_path
        else
          flash[:notice]="Unauthorized access"
          sign_out current_user
          redirect_to root_path
        end
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
