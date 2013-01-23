# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'banner/version'

Gem::Specification.new do |gem|
  gem.name          = "banner"
  gem.version       = Banner::VERSION
  gem.authors       = ["Ryan L. Cross"]
  gem.email         = ["rcross@gmail.com"]
  gem.description   = %q{Add a banner to the top of all pages in an app}
  gem.summary       = %q{Add a banner to the top of all pages in an app}
  gem.homepage      = "http://github.com/slant/banner"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
