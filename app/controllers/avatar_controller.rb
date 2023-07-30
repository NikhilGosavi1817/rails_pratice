class AvatarController < ApplicationController
    def index
    end
    def edit
    end
    def update
        user=User.find(params[:id])
        user.avatar.attach(params[:avatar][:avatar])
    end
    def destroy
        user=User.find(params[:id])
        current_user.avatar.purge
        redirect_to edit_avatar_path(current_user), notice: 'Avatar deleted successfully!'
    end
end
