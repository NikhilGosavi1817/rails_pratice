class ProfileController < ApplicationController
    before_action :set_user, only:[:edit, :update]
    def edit
    end
    def update
        if current_user.update(user_params)
            render :edit, notice: "Personal data updates successfully"
        else
            render :edit
        end

    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :age, :date_of_birth, :email, :password, :password_confirmation)
    end
    def set_user
        current_user
    end
end
