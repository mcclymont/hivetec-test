class CreateImportClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes do |t|
      t.integer :external_id
      t.integer :import_id
      t.string :name
      t.text :description
      t.integer :menus_appeared
      t.integer :times_appeared
      t.integer :first_appeared
      t.integer :last_appeared
      t.decimal :lowest_price
      t.decimal :highest_price
    end

    create_table :menus do |t|
      t.integer :external_id
      t.integer :import_id
      t.string :name
      t.string :sponsor
      t.string :event
      t.string :venue
      t.string :place
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
    end

    create_table :menu_items do |t|
      t.integer :external_id
      t.integer :import_id
      t.integer :menu_page_id
      t.decimal :price
      t.decimal :high_price
      t.integer :dish_id
      t.timestamp :created_at
      t.timestamp :updated_at
      t.decimal :xpos
      t.decimal :ypos

      t.timestamps
    end

    create_table :menu_pages do |t|
      t.integer :external_id
      t.integer :import_id
      t.integer :menu_id
      t.integer :page_number
      t.bigint :image_id
      t.integer :full_height
      t.integer :full_width
      t.string :uuid
    end
  end
end
