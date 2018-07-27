json.array! @menus do |menu|
  json.merge! menu.attributes
  json.pages menu.menu_pages.order(:page_number) do |page|
    json.merge! page.attributes
    json.items page.menu_items do |item|
      json.merge! item.attributes
      json.dish item.dish
    end
  end
end
