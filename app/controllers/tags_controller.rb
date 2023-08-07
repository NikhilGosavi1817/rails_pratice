class TagsController < ApplicationController
    def new
        @tag=Tag.new
    end

    def create
        @tag=Tag.new(tag_params)
        if @tag.save
            redirect_to tags_path, notice: 'Tag created successfully'
        else
        render :new
        end
    end
      
    def index
      @tags = Tag.paginate(page: params[:page], per_page: 10)
    end
    private

    def tag_params
        params.require(:tag).permit(:name)
    end

end
