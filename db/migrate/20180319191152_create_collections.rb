class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.string :name
      t.references :user, null: false, indes: true

      t.timestamps
    end
  end
end
