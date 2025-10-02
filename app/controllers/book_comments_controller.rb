class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book = @book

    if @book_comment.save
      redirect_to @book, notice: "You have created comment successfully."
    else
      @book_comments = @book.book_comments.includes(:user)
      @user = @book.user
      @new_book = Book.new
      render 'books/show'
    end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
