class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.references :version, foreign_key: true
      t.string :sha_hash, null: false

      t.timestamps
    end

    add_index :documents, :sha_hash
  end
end
