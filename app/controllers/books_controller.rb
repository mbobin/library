class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def index
    @books = Book
      .order(created_at: :desc)
      .page(params[:page]).per(26)
      .includes(:authors)
    @books = @books.with_tag(params[:tag]) if params[:tag].present?
    @books = @books.search(params[:q]) if params[:q].present?
    @books = Decorators::Book::Index.pagination_wrap(@books)
  end

  def show
    @book = Book.find(params[:id])
    @book = Decorators::Book::Show.new(@book)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    PipelineUpdateJob.perform_later(@book.id, isbn_param)
    redirect_to @book, notice: "Book will be updated"
  end

  private
    def isbn_param
      params.require(:book).permit(:isbn)[:isbn]
    end
end
