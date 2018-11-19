class HaltedFilesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @log = ImportLog.find(params[:id])
    @log.remove_file!
  end
end
