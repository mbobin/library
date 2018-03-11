class DocumentsController < ApplicationController
  def index
    @books ||= Book.all.includes(:authors)
  end

  def show
    document = Document.find(params[:id])
    file = document.file

    send_data file.download, type: file.content_type, disposition: :inline
  end

  def download
    document = Document.find(params[:id])
    file = document.file

    send_data file.download, type: file.content_type,
      disposition: :attachment,
      filename: "#{document.book.name}.#{document.version.book_type}"
  end
end
