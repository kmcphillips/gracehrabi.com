module SidebarHelper

  def sidebar_sections(*sections)
    html = []

    sections.each do |section|
      html << case section.to_sym
      when :events
        # TODO
      when :news
        # TODO
      when :gallery
        # TODO
      when :testimonials
        # TODO
      else
        raise SectionError, "Unknown section #{ section }"
      end
    end

    content_for(:sidebar){ html.join('').html_safe }

    nil
  end

  class SectionError < StandardError ; end

end
