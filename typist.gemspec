# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typist/version'

Gem::Specification.new do |spec|
  spec.name          = 'typist'
  spec.version       = Typist::VERSION
  spec.authors       = ['Albert Salim']
  spec.email         = ['albertlimca@gmail.com']

  spec.summary       = 'Experimental Ruby gem for type annotations'
  spec.homepage      = 'https://github.com/caalberts/typist'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/caalberts/typist'
  spec.metadata['changelog_uri'] = 'https://github.com/caalberts/typist/blob/master/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
