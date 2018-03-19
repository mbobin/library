class CrateJoinTableBooksCollections < ActiveRecord::Migration[5.2]
  def change
    create_join_table :books, :collections do |t|
      t.index [:book_id, :collection_id]
      t.index [:collection_id, :book_id]
    end
  end
end
