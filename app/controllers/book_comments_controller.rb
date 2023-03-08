class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])

    @comment = current_user.book_comments.new(book_comment_params)
      #↑と同じ意味comment = PostComment.new(post_comment_params)
    #↑と同じ意味comment.user_id = current_user.id

    @comment.book_id = @book.id
    if @comment.save
      #redirect_to request.referer
      #redirect_to request.refererを使うと簡単に同じページに遷移 #book_path(book)
      #@book_comment = BookComment.new
      render :create_form
    else
      render 'books/show'
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy

    @book = Book.find(params[:book_id])#renderしたときに@bookのデータがないので@bookを定義

    #flash.now[:alert] = '投稿を削除しました'
    #redirect_to request.referer
    render :create_form
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end