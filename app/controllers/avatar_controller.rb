class AvatarController < ApplicationController
    def index
    end
    def edit
    end
    def update
        # @user=current_user
        # if params[:user].present? && params[:user][:avatar].present?
        #     if current_user.avatar.attach(params[:user][:avatar])
        #         redirect_to edit_avatar_path(current_user), notice: 'Avatar attached'
        #     else
        #         current_user.avatar
        #         render :edit
        #     end
        # else
        #     flash[:alert]="Choose a file"
        # end

        if params[:user].present? && params[:user][:avatar].present?
            if current_user.avatar.attach(params[:user][:avatar])
              redirect_to edit_avatar_path(current_user), notice: 'Avatar updated successfully'
            else
              current_user.avatar.purge
              render :edit
            end
        else
          flash[:alert]="Choose a file"
          redirect_to edit_avatar_path(current_user)
        end
        # user=User.find(params[:id])
        # user.avatar.attach(params[:avatar][:avatar])
    end
    def destroy
        current_user.avatar.purge
        redirect_to edit_avatar_path(current_user), notice: 'Avatar deleted successfully!'
    end
end
