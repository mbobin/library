class PipelineUpdateJob < ApplicationJob
  def perform(book_id, isbn)
    Pipeline::Update.call("book_id" => book_id, "isbn" => isbn)
  end
end
