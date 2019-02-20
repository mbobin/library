class LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize ImportLog

    @logs = ImportLog.order(created_at: :desc)
    @logs = @logs.with_error if params.key?(:error)
    @logs = @logs.halted if params.key?(:halted)
    @logs = @logs.page(params[:page]).per(50)
  end
end
