class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update,:destroy]

  def show
    @book = Book.find(params[:id])
    #@user = @book.user
    #@book_show = Book.new
    #↓ｺﾒﾝﾄ用変数
    #@comment_show = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    @user = User.where.not(id: current_user.id)
    @book = Book.new
    @books = Book.all
    #@user = current_user
    #↓ｺﾒﾝﾄ用変数
    #@comment = Book.find(params[:id])
    #@book_comment = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    #@book = Book.find(params[:id])
  end

  def update
    #@book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    #@book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  #def user_params
  #  params.require(:user).permit(:name,:profile_image,:introduction)
  #end

  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
