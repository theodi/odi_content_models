# -*- encoding: utf-8 -*-
require File.expand_path('../lib/odi_content_models/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["James Smith", "Stuart Harrison"]
  gem.email         = ["james.smith@theodi.org", "stuart.harrison@theodi.org"]
  gem.description   = %q{ODI-specific models for Panopticon and Publisher}
  gem.summary       = %q{ODI-specific models for Panopticon and Publisher, as a Rails Engine}
  gem.homepage      = "https://github.com/theodi/odi_content_models"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "odi_content_models"
  gem.require_paths = ["lib", "app"]
  gem.version       = OdiContentModels::VERSION

  gem.add_dependency "govuk_content_models"

  gem.add_development_dependency "database_cleaner", "0.7.2"
  gem.add_development_dependency "factory_girl", "3.3.0"
  gem.add_development_dependency "mocha", "0.13.3"
  gem.add_development_dependency "multi_json", "1.3.7" # Pinned to allow dependency resolution
  gem.add_development_dependency "rake", "0.9.2.2"
  gem.add_development_dependency "webmock", "1.8.7"
  gem.add_development_dependency "shoulda-context", "1.0.0"
  gem.add_development_dependency "timecop", "0.5.9.2"

  # The following are added to help bundler resolve dependencies
  gem.add_development_dependency "rack", "~> 1.4.4"
end
