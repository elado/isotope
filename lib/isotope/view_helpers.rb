module Isotope
  module ViewHelpers
    def self.included(klass)
      puts "#{klass} included ViewHelpers"
    end
    
    def isotope_render_partial(view_file, options = {})
      Isotope.render_partial(ViewHelpers::resolve_view_file_path(view_file), options)
    end
  
    def isotope_render_partial_collection(view_file, options = {})
      Isotope.render_partial_collection(ViewHelpers::resolve_view_file_path(view_file), options)
    end
    
    def isotope_render_template(view_file, options = {})
      Isotope.render_template(ViewHelpers::resolve_view_file_path(view_file), options)
    end
    
    def isotope_included_scripts
      Isotope.render_included_scripts
    end
    
    private
    def self.resolve_view_file_path(view_file)
      ext = ".html.ejs" unless view_file =~ /\.[a-z]+$/i
      
      if defined? Rails
        Rails.root.join("app/views/#{view_file}#{ext}")
      else
        "views/#{view_file}#{ext}"
      end
    end
  end
end
