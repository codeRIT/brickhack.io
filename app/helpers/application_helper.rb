module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title + " - BrickHack" }
    page_title
  end

  def btn_link_to(name, path, options = {})
    options[:class] ? options[:class] += " button" : options[:class] = "button"
    link_to(name, path, options)
  end
end
