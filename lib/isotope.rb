require 'rubygems'
require 'johnson'
require 'json'

module Isotope
  @@_template_cache = {}
  
  @@cache_templates = true
  
  def cache_templates
    @@cache_templates
  end
  
  def cache_templates=(value)
    if !value
      @@_template_cache.clear
    end
    
    @@cache_templates = value
  end
  
  def self.render_partial(view_file, options = {})
    if options[:collection] && options[:collection].kind_of?(Enumerable)
      return render_partial_collection(view_file, options)
    end
    
    isotope_file_path = File.join(File.dirname(__FILE__), "isotope.js")
    
    view_file_content = template_file_content(view_file)

    script = "
      Johnson.runtime.load('#{isotope_file_path}');
      Isotope(#{view_file_content.to_json}, #{options[:locals].to_json});
    "
    
    # puts script

    output = Johnson.evaluate(script)
    
    output
  end
  
  def self.render_partial_collection(view_file, options = {})
    s = []
    
    options.delete(:collection).each { |item|
      item_options = options.dup
      item_options[:locals] ||= {}
      item_options[:locals][options[:local_name] || :item] = item

      s << render_partial(view_file, item_options)
    }
    
    s = s.join(options[:delimeter] || "")
    
    s
  end

  def self.render_template(view_file, options = {})
    options[:id] = "template" unless options[:id]

    view_file_content = template_file_content(view_file)
    template_string = "<script type=\"text/x-isotope\" id=\"#{options[:id]}\">#{view_file_content}</script>"

    template_string
  end
  
  def self.template_file_content(view_file)
    if @@cache_templates
      @@_template_cache[view_file] ||= IO.read(view_file)
    else
      IO.read(view_file)
    end
  end
end
