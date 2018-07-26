class MenuItem < ApplicationRecord
  belongs_to :import
  belongs_to :dish, ->(x) { where import_id: x.import_id }
  belongs_to :menu_page, ->(x) { where import_id: x.import_id }
end
