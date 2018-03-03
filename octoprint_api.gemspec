
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "octoprint_api/version"

Gem::Specification.new do |spec|
  spec.name          = "octoprint_api"
  spec.version       = OctoprintApi::VERSION
  spec.authors       = ["Tobias Feistmantl"]
  spec.email         = ["tobias@feistmantl.io"]

  spec.summary       = %q{Library to communicate with Octoprint API.}
  spec.description   = %q{This libarary makes it a lot easier to communicate with your Octoprint instance.}
  spec.homepage      = "https://github.com/tobiasfeistmantl/octoprint-api-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
