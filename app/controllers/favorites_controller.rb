class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @idx = params[:idx]
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # redirect_to books_path
    # redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    @idx = params[:idx]
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # redirect_to books_path
    # redirect_to request.referer
    # render :destroy
  end
end
