$:.push File.expand_path("../lib", __FILE__)

require "securitytxt/version"

Gem::Specification.new do |s|
  s.name        = "securitytxt"
  s.version     = SecurityTxt::VERSION
  s.authors     = ["Benoit Larroque"]
  s.email       = ["benoit@sqreen.io"]
  s.summary     = "Provides tools about security.txt for Ruby"
  s.description = "This gems includes various tools about security.txt for Ruby: A rails engine, A Rack MiddleWare, a simple parser and generator "
  s.license     = "MIT"

  s.files         = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.bindir        = "bin"
  s.executables   = ['securitytxt']
  s.require_paths = ["lib"]

  s.add_development_dependency "rails", "~> 5.1.4"
  s.add_development_dependency "sqlite3"
end
