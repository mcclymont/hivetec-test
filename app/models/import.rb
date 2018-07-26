class Import < ApplicationRecord
  has_many :dishes
  has_many :menus
  has_many :menu_items
  has_many :menu_pages
end
