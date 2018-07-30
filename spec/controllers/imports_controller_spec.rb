require 'rails_helper'

RSpec.describe ImportsController, type: :controller do
  let!(:import) do
    Import.create!(zip_filepath: zip_path).tap do |i|
      ImportZipService.import! i.zip_filepath, i.id
    end
  end

  render_views

  describe 'GET /imports/X/menus?export=json' do
    context 'for an empty zip' do
      let(:zip_path) { Rails.root.join 'spec', 'fixtures', 'files', 'csv', 'empty.zip' }

      it 'renders empty JSON' do
        get :menus, params: {id: import.id, export: 'json'}
        expect(response.content_type).to eq 'application/json'
        expect(JSON.parse(response.body)).to eq []
      end
    end

    context 'for a sample zip' do
      let(:zip_path) { Rails.root.join 'spec', 'fixtures', 'files', 'csv', 'sample.zip' }

      it 'renders all menus of the import in JSON' do
        get :menus, params: {id: import.id, export: 'json'}
        expect(response.content_type).to eq 'application/json'

        expected = {
          id:                   100,
          external_id:          12_576,
          import_id:            2,
          name:                 '',
          sponsor:              'U.S. ARMY - SUBSISTENCE DEPT.',
          event:                'LUNCHEON',
          venue:                'MIL;',
          place:                'TRANSPORT',
          physical_description: 'BROADSIDE; 4.5 X 7;',
          occasion:             '',
          notes:                'MENU HANDWRITTEN; SUMMER;',
          call_number:          '1900-2623',
          keywords:             nil,
          language:             nil,
          date:                 '1900-03-31',
          location:             'U.S. Army   Subsistence Dept.',
          location_type:        nil,
          currency:             nil,
          currency_symbol:      nil,
          status:               'complete',
          page_count:           2,
          dish_count:           13,
          pages:                []
        }

        expect(JSON.parse(response.body)[0].symbolize_keys).to eq expected
      end
    end
  end
end
