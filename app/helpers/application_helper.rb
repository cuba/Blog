module ApplicationHelper
  def full_title(page_title)
    base_title = "Sudo Code"
    return base_title if page_title.empty?
    return "#{base_title} | #{page_title}"
  end

  def redcloth(content)
    #return content + "<br /><br /><br /><br />"
    r = RedCloth.new content
    r.to_html
  end
end
