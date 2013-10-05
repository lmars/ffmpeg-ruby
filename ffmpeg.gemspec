# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "ffmpeg"
  spec.version       = "0.0.1"
  spec.authors       = ["Lewis Marshall"]
  spec.email         = ["lewis@lmars.net"]
  spec.description   = %q{A gem for accessing FFmpeg functions}
  spec.summary       = %q{A gem for accessing FFmpeg functions}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "rspec"
end
