class CreateImportClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes do |t|
      t.integer :external_id
      t.references :import, foreign_key: true, null: false
      t.string :name
      t.text :description
      t.integer :menus_appeared
      t.integer :times_appeared
      t.integer :first_appeared
      t.integer :last_appeared
      t.decimal :lowest_price
      t.decimal :highest_price
      t.index [:import_id, :external_id]
    end

    create_table :menus do |t|
      t.integer :external_id
      t.references :import, foreign_key: true, null: false
      t.string :name
      t.string :sponsor
      t.string :event, index: true
      t.string :venue, index: true
      t.string :place, index: true
      t.string :physical_description
      t.string :occasion
      t.text :notes
      t.string :call_number
      t.text :keywords
      t.string :language
      t.date :date
      t.string :location
      t.string :location_type
      t.string :currency
      t.string :currency_symbol
      t.string :status
      t.integer :page_count
      t.integer :dish_count
      t.index [:import_id, :external_id]
    end

    create_table :menu_items do |t|
      t.integer :external_id
      t.references :import, foreign_key: true, null: false
      t.integer :menu_page_id
      t.decimal :price
      t.decimal :high_price
      t.integer :dish_id
      t.timestamp :created_at
      t.timestamp :updated_at
      t.decimal :xpos
      t.decimal :ypos

      t.timestamps
      t.index [:import_id, :menu_page_id]
    end

    create_table :menu_pages do |t|
      t.integer :external_id
      t.references :import, foreign_key: true, null: false
      t.integer :menu_id
      t.integer :page_number
      t.bigint :image_id
      t.integer :full_height
      t.integer :full_width
      t.string :uuid
      t.index [:import_id, :external_id]
    end
  end
end
