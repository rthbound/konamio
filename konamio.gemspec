# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "konamio/version"

Gem::Specification.new do |s|
  s.name        = "konamio"
  s.version     = Konamio::VERSION
  s.authors     = ["Tad Hosford"]
  s.email       = ["tad.hosford@gmail.com"]
  s.homepage    = "https://github.com/rthbound/konamio"
  s.summary     = "I'm gonna recognize the konami sequence"
  s.description = "Recognize sequences in Ruby... just for fun."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency "pay_dirt"
  s.add_development_dependency "minitest"
  s.add_development_dependency "pry"
  s.add_development_dependency "rake"
end
