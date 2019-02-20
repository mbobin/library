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
    authorize @book
  end

  def update
    @book = Book.find(params[:id])
    authorize @book

    if @book.update(book_params)
      PipelineUpdateJob.perform_later(@book.id, @book.isbn) if @book.update_from_isbn
      redirect_to @book, notice: "Book will be updated"
    else
      render :edit
    end
  end

  private
    def book_params
      params
        .require(:book)
        .permit(:isbn, :name, :description, :update_from_isbn, tags: [])
        .tap do |prms|
          prms[:tags] = prms[:tags].select(&:present?)
          prms[:update_from_isbn] = string_to_bool(prms[:update_from_isbn])
        end
    end

    def string_to_bool(value)
      ActiveRecord::Type::Boolean.new.cast(value)
    end

    def autofocus_search_input?
      params.except(:controller, :action).empty?
    end
    helper_method :autofocus_search_input?
end
