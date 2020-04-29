class BooksController < ApplicationController
before_action :authenticate_user!, only: [:index, :show, :edit]

before_action :correct_user, only: [:edit, :update]
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      flash[:success] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render template: 'users/show'
    end
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    #@book = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
      if @book.update(book_params)
        flash[:success] = "Book was successfully update."
        redirect_to book_path(@book.id)
      else
        render action: :edit
    end
  end

  def destroy
  	@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_index_path
  end

    private
      def book_params
        params.require(:book).permit(:title, :body, :user_id)
      end

      def correct_user
            book = Book.find(params[:id])
         
        if book.user_id != current_user.id
          flash[:notice] = "権限がありません"
          redirect_to books_path
        end
      end
end