module SidebarHelper

  def sidebar_sections(*sections)
    html = []

    sections.each do |section|
      case section.to_sym
      when :events
        @sidebar_events = Event.current_and_upcoming.limit(5)
      when :news
        @sidebar_posts = Post.recent
      when :gallery
        @sidebar_images = Image.random_sample
      when :testimonials
        @sidebar_testimonials = Testimonial.active
      else
        raise SectionError, "Unknown section #{ section }"
      end

      html << render(partial: "/shared/sidebar/#{ section }")
    end

    content_tag(:div, html.join('').html_safe, class: 'sidebar')
  end

  class SectionError < StandardError ; end

end
