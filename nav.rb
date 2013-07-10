module AutoNav
  class << self
    def registered(app)
      app.helpers HelperMethods
    end
    alias :included :registered
  end

  module HelperMethods
    def left_nav
      partial 'shared/left_nav'
    end

    def nav_load_page_content
      path = current_page.source_file
      while ::Tilt[path]
        @content = render_individual_file(path)
        path = File.basename(path, File.extname(path))
      end
      @content
    end

    def left_nav_data
      nav_load_page_content
      page = Nokogiri::HTML(@content)
      @sidebar_links = []
      page.css("a").select{|link| link['href'].blank? }.each do |link|
        @sidebar_links << {:target => link['id'], :class => link['class'], :title => link['title'] ? link['title'] : link['id'].titleize}
      end
      @sidebar_links
    end

    def top_nav_data
      links = []
      sitemap.resources.each do |resource|
        if resource.data.nav
          match = /^(?<sort>\d*) (?<nav_title>.*)/.match(resource.data.nav)
          links << {:href => resource.destination_path, :page_classes => page_classes_for(resource), :sort => match[:sort], :nav_title => match[:nav_title]}
        end
      end
      links.sort_by { |link| link[:sort] }
    end

    def page_classes_for resource
      path = resource.destination_path
      path << index_file if path.match(%r{/$})
      path = path.gsub(%r{^/}, '')

      classes = []
      parts = path.split('.')[0].split('/')
      parts.each_with_index { |path, i| classes << parts.first(i+1).join('_') }

      classes.join(' ')
    end

    def section(title)
      anchor = title.slugify
      title = HTMLEntities.new.encode title
      partial 'shared/section_title', :locals => {:title => title, :anchor => anchor}
    end
  end


end
::Middleman::Extensions.register(:auto_nav, AutoNav)
