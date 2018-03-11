class CreateImportLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :import_logs do |t|
      t.jsonb :data, default: {}, null: false

      t.timestamps
    end
  end
end
