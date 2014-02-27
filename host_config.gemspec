$:.push File.expand_path("../lib", __FILE__)
require "host_config"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "host_config"
  s.summary     = "Simple per-host configuration for Ruby apps."
  s.description = %{
    HostConfig is easy app configuration for Ruby apps that
    uses yml files to build up a nested OpenStruct for use globally
    in an app.
  }
  s.version     = HostConfig::VERSION
  s.authors     = ["Ryan Funduk"]
  s.email       = ["ryan.funduk@gmail.com"]
  s.homepage    = "https://github.com/rfunduk/host_config"
  s.license     = "MIT"

  s.files = Dir["{lib}/*", "LICENSE", "Rakefile", "README.md"]

  s.add_development_dependency "rails", "~> 4.0"
  s.add_runtime_dependency 'activesupport', '>= 3.0.0'
end
