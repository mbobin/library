class LibraryController < ApplicationController
  def index
    @cluster = ApplicationRecord.connection.execute("select word, count(word) \
       as frequency from(select(unnest(tags)) as word from books) words group \
        by word order by 2 desc"
      ).to_a
  end
end
