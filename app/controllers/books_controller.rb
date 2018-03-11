class BooksController < ApplicationController
  def index
    @books = Book
      .includes(:authors, pdf_versions: :documents,
        downloadable_versions: :documents)
    @books = @books.with_tag(params[:tag]) if params[:tag].present?
    @books = @books.order(created_at: :desc)
  end
end
