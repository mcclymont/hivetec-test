require 'rails_helper'

RSpec.describe ImportZipService do
  let(:import) { Import.create! zip_filepath: zip_path }

  context 'for a zip file with empty csvs' do
    let(:zip_path) { Rails.root.join 'spec', 'fixtures', 'files', 'csv', 'empty.zip' }

    it 'creates no new models' do
      menu_count = Menu.count
      dish_count = Dish.count
      menu_item_count = MenuItem.count
      menu_page_count = MenuPage.count

      ImportZipService.import! import.zip_filepath, import.id

      expect(Menu.count).to eq menu_count
      expect(Dish.count).to eq dish_count
      expect(MenuItem.count).to eq menu_item_count
      expect(MenuPage.count).to eq menu_page_count
    end
  end

  context 'for a zip file with sample data' do
    let(:zip_path) { Rails.root.join 'spec', 'fixtures', 'files', 'csv', 'sample.zip' }

    it 'creates 100 new models for each type' do
      menu_count = Menu.count
      dish_count = Dish.count
      menu_item_count = MenuItem.count
      menu_page_count = MenuPage.count

      ImportZipService.import! import.zip_filepath, import.id

      expect(Menu.count).to eq menu_count + 100
      expect(Dish.count).to eq dish_count + 100
      expect(MenuItem.count).to eq menu_item_count + 100
      expect(MenuPage.count).to eq menu_page_count + 100
    end

    it 'sets the dish attributes correctly' do
      ImportZipService.import! import.zip_filepath, import.id

      dish = Dish.find_by(external_id: 1, import_id: import.id)
      expect(dish.attributes.symbolize_keys.except(:id)).to eq(
        external_id: 1,
        import_id: import.id,
        name: 'Consomme printaniere royal',
        description: nil,
        menus_appeared: 8,
        times_appeared: 9,
        first_appeared: 1897,
        last_appeared: 1927,
        lowest_price: 0.2,
        highest_price: 0.4
      )

      expect(dish.menu_items.count).to eq 1
    end

    it 'sets the menu attributes correctly' do
      ImportZipService.import! import.zip_filepath, import.id

      menu = Menu.find_by(external_id: 12_463, import_id: import.id)
      expect(
        menu.attributes.symbolize_keys.except(:id)
      )
        .to eq(
          external_id: 12_463,
          import_id: import.id,
          name: nil,
          sponsor: 'HOTEL EASTMAN',
          event: 'BREAKFAST',
          venue: 'COMMERCIAL',
          place: 'HOT SPRINGS, AR',
          physical_description: 'CARD; 4.75X7.5;',
          occasion: 'EASTER;',
          notes: '',
          call_number: '1900-2822',
          keywords: nil,
          language: nil,
          date: DateTime.parse('1900-04-15'),
          location: 'Hotel Eastman',
          location_type: nil,
          currency: nil,
          currency_symbol: nil,
          status: 'complete',
          page_count: 2,
          dish_count: 67
        )

      expect(menu.menu_pages.count).to eq 2
    end

    it 'sets the menu page attributes correctly' do
      ImportZipService.import! import.zip_filepath, import.id

      page = MenuPage.find_by(external_id: 119, import_id: import.id)
      expect(
        page.attributes.symbolize_keys.except(:id)
      )
        .to eq(
          external_id: 119,
          import_id: import.id,
          menu_id: 12_460,
          page_number: 1,
          image_id: 1_603_595,
          full_height: 7230,
          full_width: 5428,
          uuid: '510d47e4-2955-a3d9-e040-e00a18064a99'
        )

      expect(page.menu).to eq Menu.find_by(import: import, external_id: 12_460)
      expect(page.menu_items.count).to eq 0
    end

    it 'sets the menu item attributes correctly' do
      ImportZipService.import! import.zip_filepath, import.id

      item = MenuItem.find_by(external_id: 1, import_id: import.id)
      expect(
        item.attributes.symbolize_keys.except(:id)
      )
        .to eq(
          external_id: 1,
          import_id: import.id,
          menu_page_id: 1389,
          price: 0.4,
          high_price: nil,
          dish_id: 1,
          created_at: Time.parse('2011-03-28 15:00:44 UTC'),
          updated_at: Time.parse('2011-04-19 04:33:15 UTC'),
          xpos: 0.111429,
          ypos: 0.254735
        )

      expect(item.dish).to eq Dish.find_by(import: import, external_id: 1)
      expect(item.menu_page).to eq MenuPage.find_by(import: import, external_id: 1389)
    end
  end
end
