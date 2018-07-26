class Dish < ApplicationRecord
  belongs_to :import
  has_many :menu_items, ->(x) { where import_id: x.import_id }
end
