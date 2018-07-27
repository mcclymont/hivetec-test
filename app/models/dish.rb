class Dish < ApplicationRecord
  belongs_to :import
  has_many :menu_items, ->(x) { where import_id: x.import_id }, primary_key: :external_id
end
