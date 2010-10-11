module ApplicationHelper
  
  def page_title
    prefix = PAGE_TITLE
    prefix = "#{prefix} - Admin" if params[:controller] =~ /^admin\//

    if @title
      "#{prefix} - #{@title}"
    elsif params[:controller] =~ /blocks$/
      "#{prefix} - #{params[:action].humanize}"
    else
      prefix
    end
  end
  
  
end
