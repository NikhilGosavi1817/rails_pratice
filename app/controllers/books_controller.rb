class BooksController < ApplicationController
    def new
        @book=Book.new
    end

    def create
        @book=current_user.books.new(book_params)
        if @book.save
            @book.tag_ids=params[:book][:tag_ids]
            redirect_to root_path, notice: "Book created"
        else
            render :new
        end
    end
    def book_params
        params.require(:book).permit(:name, :description, :number_of_copy, tag_ids: [])
    end

    def list
        @book=Book.all
        if params[:sort].present?
            sort_column=params[:sort]
            sort_direction=params[:direction] || "desc"
            @book=@book.order("#{sort_column} #{sort_direction}")
        end
            @book=@book.paginate(page: params[:page], per_page: 10)
    end

    def show
        @book = Book.find(params[:id])
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path, notice: 'Book was successfully removed.'
    end

    def archive
        @book = Book.find(params[:id])
        @book.update(status: 'archived')
        redirect_to book_path(@book), notice: 'Book was successfully archived.'
    end

end
