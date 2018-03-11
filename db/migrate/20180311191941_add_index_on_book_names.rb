class AddIndexOnBookNames < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        execute("CREATE INDEX books_on_name_idx ON books USING gin(name gin_trgm_ops);")
      end

      dir.down do
        execute("DROP INDEX book_names_idx;")
      end
    end
  end
end
