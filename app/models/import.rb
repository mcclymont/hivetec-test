require 'zip'

class Import < ApplicationRecord
  has_many :dishes
  has_many :menus
  has_many :menu_items
  has_many :menu_pages

  after_initialize :set_defaults
  after_commit -> { ImportZipJob.perform_later id }, on: :create, if: -> { status == 'uploaded' }

  validates :zip_filepath, presence: true
  validate :file_type_zip

  private

  def file_type_zip
    return if zip_filepath.blank?

    zip = Zip::File.open(zip_filepath)
  rescue StandardError => e
    Rails.logger.error e
    errors.add :zip_data, 'is not a valid zip file'
  ensure
    zip&.close
  end

  def set_defaults
    self.status ||= 'uploaded'
  end
end
