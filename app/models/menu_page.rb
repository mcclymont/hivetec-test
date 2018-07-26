class MenuPage < ApplicationRecord
  belongs_to :import
  belongs_to :menu, ->(x) { where import_id: x.import_id }
  has_many :menu_items, ->(x) { where import_id: x.import_id }
end
