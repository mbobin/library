class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :versions do |t|
      t.references :book, foreign_key: true
      t.datetime :published_at
      t.integer :book_type, null: false, default: 0

      t.timestamps
    end
  end
end
