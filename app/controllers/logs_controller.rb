class LogsController < ApplicationController
  def index
    @logs = ImportLog.order(created_at: :desc).page(params[:page]).per(50)
  end
end
