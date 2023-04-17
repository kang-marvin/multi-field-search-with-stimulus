module ApplicationHelper

  def header_text_cleaner(name)
    name.titleize.gsub('_', ' ')
  end
end
