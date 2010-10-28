# encoding: utf-8
require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name     = 'isotope'
  gem.version  = Isotope::VERSION::STRING
  gem.date     = Time.now.strftime('%Y-%m-%d')
  gem.platform = Gem::Platform::RUBY
    
  gem.summary = "Ruby Hybrid (Server and Client sides) templates"
  gem.description = "Isotope provides an easy way to use a signle EJS template on both server and client side"
  
  gem.authors  = ['Elad Ossadon']
  gem.email    = 'elad@ossadon.com'
  gem.homepage = 'http://github.com/elado/ruby-hybrid-templates/wikis'

  
  gem.rubyforge_project = nil
  gem.has_rdoc = true
  gem.rdoc_options = ['--main', 'README.rdoc', '--charset=UTF-8']
  gem.extra_rdoc_files = ['README.rdoc', 'LICENSE', 'CHANGELOG.rdoc']
  
  gem.files = Dir['{lib,test}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  
  gem.add_development_dependency 'json'
  gem.add_development_dependency 'johnson'
  gem.add_development_dependency 'rspec'
end

