$:.push File.expand_path("../lib", __FILE__)
require "host_config"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "host_config"
  s.description = "HostConfig is easy app configuration for Ruby apps."
  s.version     = HostConfig::VERSION
  s.authors     = ["Ryan Funduk"]
  s.email       = ["ryan.funduk@gmail.com"]
  s.homepage    = "https://github.com/rfunduk/host_config"
  s.summary     = "Simple per-host configuration for Rails 4."
  s.license     = "MIT"

  s.files = Dir["{lib}/*", "LICENSE", "Rakefile", "README.md"]

  s.add_development_dependency "rails", "~> 4.0"
end
