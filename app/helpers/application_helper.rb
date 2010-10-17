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
  
  def index_entity_image(path, label=nil, args={})
    path = polymorphic_path(path) if path.is_a?(Array)
    html = link_to(image_tag("/images/icons/index.png", :alt => "Index"), path, :title => "Index")
    html += " " + link_to(label, path) if label
    html
  end

  def new_entity_image(path, label=nil, args={})
    path = polymorphic_path(path) if path.is_a?(Array)
    html = link_to image_tag("/images/icons/new.png", :alt => "New"), path, :title => "New"
    html += " " + link_to(label, path) if label
    html
  end

  def delete_entity_image(path, label=nil, args={})
    path = polymorphic_path(path) if path.is_a?(Array)
    html = link_to image_tag("/images/icons/delete.png", :alt => "Delete", :class => "action-image"), path, :method => :delete, :confirm => "Are you sure you want to delete this?", :title => "Delete"
    html += " " + link_to(label, path, :method => :delete, :confirm => "Are you sure you want to delete this?") if label
    html
  end

  def edit_entity_image(path, label=nil, args={})
    path = polymorphic_path(path) if path.is_a?(Array)
    html = link_to image_tag("/images/icons/edit.png", :alt => "Edit"), path, :title => "Edit", :class => "action-image"
    html += " " + link_to(label, path) if label
    html
  end

  def show_entity_image(path, label=nil, args={})
    path = polymorphic_path(path) if path.is_a?(Array)
    html = link_to image_tag("/images/icons/show.png", :alt => "Show", :class => "action-image"), path, :title => "Show"
    html += " " + link_to(label, path) if label
    html
  end

  def enlarge_button
    "Enlarge&nbsp;" + image_tag("/images/icons/magnify.png", :alt => "Enlarge", :class => :magnify)
  end

  def boolean_image(value)
    image_tag("/images/icons/#{!!value}.png", :alt => (!!value).to_s.humanize)
  end

  def obfuscated_mail_to(email, label=nil)
    obfuscated = email.scan(/.{1,10}/).join("[REMOVE_THIS]")
    mail_to(email, label, :encode => "javascript") + "<noscript>#{mail_to(obfuscated, label || email.sub(/\@.*/, ""))}</noscript>"
  end

end
