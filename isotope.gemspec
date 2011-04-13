# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{isotope}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Elad Ossadon"]
  s.cert_chain = ["/Users/Elad/.pem/gem-public_cert.pem"]
  s.date = %q{2010-10-30}
  s.description = %q{Isotope provides an easy way to use a signle EJS template on both server and client side}
  s.email = %q{elad@ossadon.com}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "LICENSE", "README.md", "lib/isotope.js", "lib/isotope.rb", "lib/version.rb"]
  s.files = ["CHANGELOG.rdoc", "Gemfile", "Gemfile.lock", "LICENSE", "Manifest", "README.md", "Rakefile", "examples/rails3-example/Gemfile", "examples/rails3-example/Gemfile.lock", "examples/rails3-example/README", "examples/rails3-example/Rakefile", "examples/rails3-example/app/controllers/application_controller.rb", "examples/rails3-example/app/controllers/articles_controller.rb", "examples/rails3-example/app/helpers/application_helper.rb", "examples/rails3-example/app/helpers/articles_helper.rb", "examples/rails3-example/app/views/articles/article.html.ejs", "examples/rails3-example/app/views/articles/show_client.html.erb", "examples/rails3-example/app/views/articles/show_server_template_in_view.html.erb", "examples/rails3-example/app/views/layouts/application.html.erb", "examples/rails3-example/config.ru", "examples/rails3-example/config/application.rb", "examples/rails3-example/config/boot.rb", "examples/rails3-example/config/database.yml", "examples/rails3-example/config/environment.rb", "examples/rails3-example/config/environments/development.rb", "examples/rails3-example/config/environments/production.rb", "examples/rails3-example/config/environments/test.rb", "examples/rails3-example/config/initializers/backtrace_silencers.rb", "examples/rails3-example/config/initializers/inflections.rb", "examples/rails3-example/config/initializers/mime_types.rb", "examples/rails3-example/config/initializers/secret_token.rb", "examples/rails3-example/config/initializers/session_store.rb", "examples/rails3-example/config/locales/en.yml", "examples/rails3-example/config/routes.rb", "examples/rails3-example/db/development.sqlite3", "examples/rails3-example/db/seeds.rb", "examples/rails3-example/doc/README_FOR_APP", "examples/rails3-example/public/404.html", "examples/rails3-example/public/422.html", "examples/rails3-example/public/500.html", "examples/rails3-example/public/favicon.ico", "examples/rails3-example/public/images/rails.png", "examples/rails3-example/public/index.html", "examples/rails3-example/public/javascripts/application.js", "examples/rails3-example/public/javascripts/controls.js", "examples/rails3-example/public/javascripts/dragdrop.js", "examples/rails3-example/public/javascripts/effects.js", "examples/rails3-example/public/javascripts/isotope.js", "examples/rails3-example/public/javascripts/prototype.js", "examples/rails3-example/public/javascripts/rails.js", "examples/rails3-example/public/robots.txt", "examples/rails3-example/script/rails", "examples/rails3-example/test/functional/articles_controller_test.rb", "examples/rails3-example/test/performance/browsing_test.rb", "examples/rails3-example/test/test_helper.rb", "examples/rails3-example/test/unit/helpers/article_helper_test.rb", "examples/rails3-example/test/unit/helpers/articles_helper_test.rb", "examples/rails3-example/tmp/pids/server.pid", "examples/sinatra-example/server.rb", "isotope.gemspec", "lib/isotope.js", "lib/isotope.rb", "lib/version.rb", "test/article.ejs", "test/isotope_spec.rb"]
  s.homepage = %q{http://github.com/elado/isotope}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Isotope", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{isotope}
  s.rubygems_version = %q{1.3.7}
  s.signing_key = %q{/Users/Elad/.pem/gem-private_key.pem}
  s.summary = %q{Ruby Hybrid (Server and Client sides) templates}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
