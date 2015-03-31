# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'taric/version'

Gem::Specification.new do |spec|
  spec.name          = "taric"
  spec.version       = Taric::VERSION
  spec.authors       = ["Joseph Yi"]
  spec.email         = ["dissonance@gmail.com"]

  spec.summary       = %q{An outrageous Riot Games LoL API Client}
  spec.description   = %q{An outrageous Riot Games LoL API Client}
  spec.homepage      = "http://github.com/josephyi/taric"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files += Dir.glob("lib/**/*.rb")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_development_dependency "bundler", ">= 1.7", '< 2.0'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'webmock', '~> 1.20'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'coveralls', '~> 0.7'

  spec.add_dependency 'typhoeus', "~> 0.3"
  spec.add_runtime_dependency 'memoist', '~> 0.11'
  spec.add_runtime_dependency('addressable', '~> 2.3')
  spec.add_runtime_dependency('oj', '~> 2.12')
  spec.add_runtime_dependency('faraday_middleware', '~> 0.9')
  spec.add_runtime_dependency('faraday_middleware-parse_oj', '~> 0.3.0')
end
