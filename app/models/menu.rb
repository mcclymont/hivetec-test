class Menu < ApplicationRecord
  belongs_to :import
  has_many :menu_pages, ->(x) { where import_id: x.import_id }
end
