class LogsController < ApplicationController
  def index
    @logs = ImportLog.order(created_at: :desc)
    @logs = @logs.with_error if params.key?(:error)
    @logs = @logs.halted if params.key?(:halted)
    @logs = @logs.page(params[:page]).per(50)
  end
end
