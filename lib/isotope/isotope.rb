require 'rubygems'
require 'execjs'
require 'json'
require 'yaml'
require 'erb'

module Isotope
  APP_ROOT = File.expand_path((defined?(Rails) && Rails.root.to_s.length > 0) ? Rails.root : ".") unless defined?(APP_ROOT)
  DEFAULT_CONFIG_PATH = File.join(APP_ROOT, 'config', 'isotope.yml')
  DEFAULT_CONFIG = {}
  PUBLIC_DIR_PREFIX = %r[^/?public]

  @@_template_cache = {}
  
  @@cache_templates = true
  
  def self.cache_templates
    !dev_env && @@cache_templates
  end

  def self.cache_templates=(value)
    if !value
      @@_template_cache.clear
    end
    
    @@cache_templates = value
  end
  
  def self.reset_cache
    @@_template_cache.clear
  end
  
  def self.render_partial(view_file, options = {})
    if options[:collection] && options[:collection].kind_of?(Enumerable)
      return render_partial_collection(view_file, options)
    end
    
    isotope_file_path = File.join(File.dirname(__FILE__), "isotope.js")
    
    view_file_content = template_file_content(view_file)
    
    initial_script = included_scripts_source ? included_scripts_source + ";" : ""
    initial_script << IO.read(isotope_file_path)

    context = ExecJS.compile(initial_script)
    script = "Isotope(#{view_file_content.to_json}, #{options[:locals].to_json})"
    output = context.eval(script)

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
    
    s = s.join(options[:delimiter] || "")
    
    s
  end

  def self.render_template(view_file, options = {})
    options[:id] = "template" unless options[:id]

    view_file_content = template_file_content(view_file)
    template_string = "<script type=\"text/x-isotope\" id=\"#{options[:id]}\">#{view_file_content}</script>"

    template_string
  end
  
  def self.render_included_scripts
    include_scripts = config["include_scripts"]
    return if !include_scripts || include_scripts.empty?
    
    include_scripts.map! { |path|
      if defined? Rails && path =~ PUBLIC_DIR_PREFIX
        path = path.gsub(PUBLIC_DIR_PREFIX, "")
      end
      
      "<script src=\"#{path}\"></script>"
    }
    
    include_scripts.join
  end
  
  private
  def self.dev_env
    if defined? Rails
      Rails.env.development?
    elsif defined? Rack
      Rack.env.development?
    end
  end

  @@_config = nil

  def self.config
    return @@_config if @@_config && !dev_env

    if File.exists?(DEFAULT_CONFIG_PATH)
      config = YAML.load(ERB.new(IO.read(DEFAULT_CONFIG_PATH)).result)
    end

    config = {} unless config
    config.merge!(DEFAULT_CONFIG)
    @@_config = config
  end
  
  def self.template_file_content(view_file)
    if cache_templates
      @@_template_cache[view_file] ||= IO.read(view_file)
    else
      IO.read(view_file)
    end
  end

  @@_included_scripts_source = nil

  def self.included_scripts_source
    return @@_included_scripts_source if @@_included_scripts_source && !dev_env
    
    include_scripts = config["include_scripts"]
    
    if include_scripts && !include_scripts.empty?
      @@_included_scripts_source = include_scripts.map { |path|
        path = File.join(APP_ROOT, path)
        IO.read(path) if File.exists?(path)
      }.join(";\n")
    end
  end
end