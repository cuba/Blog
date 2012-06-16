module ApplicationHelper
  require 'cgi'

  def full_title(page_title)
    base_title = "Sudo Code"
    return base_title if page_title.empty?
    return "#{base_title} | #{page_title}"
  end

  def redcloth(content)
    r = RedCloth.new content
    r.to_html
  end

  def sanitizeHTML(content)
    return CGI.escapeHTML(content)
    content.gsub(/</, '&lt;')
    content.gsub(/>/, '&gt;')
  end
end
