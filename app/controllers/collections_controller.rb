class CollectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @collections = current_user.collections.includes(:books).order(:name)
  end

  def new
    @collection = current_user.collections.new
    authorize @collection
  end

  def create
    @collection = current_user.collections.new(collection_params)
    if @collection.save
      redirect_to collections_path, notice: "Collection was successfully created."
    else
      render :new
    end
  end

  private

    def collection_params
      params.require(:collection).permit(:name)
    end
end
