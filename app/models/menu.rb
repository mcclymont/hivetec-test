class Menu < ApplicationRecord
  belongs_to :import
  has_many :menu_pages, ->(x) { where import_id: x.import_id }, primary_key: :external_id
end
