class SearchesController < ApplicationController
  def search
    if params[:category] == "User"
      redirect_to request.referer
    else
      @keyword = params[:title]
      if params[:search_type] == "完全一致"
        @books = Book.where(title: params[:title])
      elsif params[:search_type] == "前方一致"
        @books = Book.where("title LIKE ?", params[:title]+"%")
      elsif params[:search_type] == "後方一致"
        @books = Book.where("title LIKE ?", "%"+params[:title])
      else
        @books = Book.where("title LIKE ?", "%"+params[:title]+"%")
      end
    end
  end
end
