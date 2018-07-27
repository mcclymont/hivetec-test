module ApplicationHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? ' active' : ''
    content_tag(:li, class: 'nav-item' + class_name) do
      link_to link_text, link_path, class_name: 'nav-link'
    end
  end

  def null_helper(value)
    value.present? ? value : '[BLANK]'
  end
end
