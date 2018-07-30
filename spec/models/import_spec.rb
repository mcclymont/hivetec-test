require 'rails_helper'

RSpec.describe ImportZipJob, type: :model do
  let(:zip_path) { Rails.root.join 'spec', 'fixtures', 'files', 'csv', 'empty.zip' }
  let(:import) { Import.new zip_filepath: zip_path }

  it 'gives a default status and saves with valid data' do
    expect(Import.create!(zip_filepath: zip_path).status).to eq 'uploaded'
  end

  it 'is not valid without a zip_filepath' do
    import = Import.new
    expect(import).to_not be_valid
    expect(import.errors[:zip_filepath].first).to match(/can't be blank/)
  end

  context 'when the zip_filepath does not exist' do
    let(:zip_path) { Rails.root.join 'tmp', 'non existent file' }
    it 'is not valid' do
      expect(import).to_not be_valid
      expect(import.errors[:zip_data].first).to match(/is not a valid zip file/)
    end
  end

  context 'when the zip_filepath is not a zip file' do
    let(:zip_path) { Rails.root.join 'app', 'models', 'import.rb' }
    it 'is not valid' do
      expect(import).to_not be_valid
      expect(import.errors[:zip_data].first).to match(/is not a valid zip file/)
    end
  end
end
