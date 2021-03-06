class CreateImports < ActiveRecord::Migration[5.0]
  def change
    create_table :imports do |t|
      t.string :status, null: false
      t.string :zip_filepath, null: false

      t.integer :processing_time_seconds
      t.timestamps
    end
  end
end
