module Books
  class CollectionsController < ApplicationController
    before_action :authenticate_user!

    def edit
      @book = Book.find(params[:book_id])
    end

    def update
      @book = Book.find(params[:book_id])
      @book.update(collection_ids: permitted_collection_ids)
    end

    private

    def permitted_collection_ids
      collection_ids = params
        .require(:book)
        .permit(collection_ids: [])
        .fetch(:collection_ids, [])
        .map(&:to_i)

      current_user.collection_ids & collection_ids
    end
  end
end
