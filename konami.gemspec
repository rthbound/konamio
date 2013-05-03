$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "konami/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "konami"
  s.version     = Konami::VERSION
  s.authors     = ["Tad Hosford"]
  s.email       = ["tad.hosford@gmail.com"]
  s.homepage    = "https://github.com/rthbound/konami"
  s.summary     = "I'm gonna recognize the konami sequence"
  s.description = "Recognize sequences in Ruby... I dunno why."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]


end
