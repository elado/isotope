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
      if defined? Rails
        Rails.root.join("app/views/#{view_file}.html.ejs")
      else
        "views/#{view_file}.html.ejs"
      end
    end
  end
end
