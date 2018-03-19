class CollectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @collections = current_user.collections.includes(:books)
  end

  def new
  end

  def create
  end
end
