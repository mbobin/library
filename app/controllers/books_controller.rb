class BooksController < ApplicationController
  def index
    @books = Book
      .order(created_at: :desc)
      .page(params[:page]).per(26)
      .includes(:authors, pdf_versions: :documents,
        downloadable_versions: :documents)
    @books = @books.with_tag(params[:tag]) if params[:tag].present?
    @books = Decorators::Book::Index.pagination_wrap(@books)
  end

  def show
    @book = Book.find(params[:id])
    @book = Decorators::Book::Show.new(@book)
  end
end
