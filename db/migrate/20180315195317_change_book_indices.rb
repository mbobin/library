require_relative "20180311191941_add_index_on_book_names"

class ChangeBookIndices < ActiveRecord::Migration[5.2]
  def change
    revert AddIndexOnBookNames

    reversible do |dir|
      dir.up do
        execute("CREATE INDEX books_on_name_idx ON books USING gin(name gin_trgm_ops, description gin_trgm_ops);")
      end

      dir.down do
        execute("DROP INDEX books_on_name_idx;")
      end
    end
  end
end
