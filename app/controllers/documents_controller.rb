class DocumentsController < ApplicationController
  def index
    @books ||= Book.all.includes(:authors)
  end

  def show
    file = document.file

    send_data file.download, type: file.content_type, disposition: :inline
  end

  def download
    file = document.file

    send_data file.download, type: file.content_type,
      disposition: :attachment,
      filename: "#{document.book.name}.#{document.version.book_type}"
  end

  def convert
    authorize document

    PipelineConvertJob.perform_later(document)
    redirect_to document.book, notice: "Conversion enqueued"
  end

  private

  def document
    @document ||= Document.find(params[:id])
  end
end
