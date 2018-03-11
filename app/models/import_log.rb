class ImportLog < ApplicationRecord
  def fail?
    data["error"] || !(data["author_ids"] && data["book_id"])
  end
end
