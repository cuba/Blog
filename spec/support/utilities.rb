def full_title(page_title)
  base_title = "Sudo Code"
  return base_title if page_title.empty?
  return "#{base_title} | #{page_title}"
end