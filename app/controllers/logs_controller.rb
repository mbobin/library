class LogsController < ApplicationController
  def index
    @logs = ImportLog.order(created_at: :desc)
  end
end
