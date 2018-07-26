require 'zip'

class ImportZipService
  IMPORTERS = {
    menu: {
      class: Menu,
      attributes: %w[id name sponsor event venue place physical_description occasion notes call_number keywords
                     language date location location_type currency currency_symbol status page_count dish_count]
    },
    menuitem: {
      class: MenuItem,
      attributes: %w[id menu_page_id price high_price dish_id created_at updated_at xpos ypos]
    },
    dish: {
      class: Dish,
      attributes: %w[id name description menus_appeared times_appeared first_appeared last_appeared
                     lowest_price highest_price]
    },
    menupage: {
      class: MenuPage,
      attributes: %w[id menu_id page_number image_id full_height full_width uuid]
    }
  }.stringify_keys

  def self.import!(zip_path, import_id)
    Zip::File.open(zip_path) do |zipfile|
      zipfile.each do |file|
        name = File.basename(file.name).downcase.remove('.csv')
        importer = IMPORTERS[name]
        next unless importer

        Rails.logger.debug "Importing #{name}"

        header = importer[:attributes]

        data = Rcsv.parse(
          file.get_input_stream.read,
          row_as_hash: true,
          header: :use,
          columns: header.map { |x| [x, { alias: x }] }.to_h
        ).map do |row|
          {}.tap do |rvalue|
            header.each { |col| rvalue[col] = row[col] }
            rvalue['external_id'] = rvalue.delete('id')
            rvalue['import_id'] = import_id
          end
        end

        importer[:class].import data, validate: false
      end
    end
    nil
  end
end
