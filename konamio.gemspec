# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "konamio/version"

Gem::Specification.new do |s|
  s.name        = "konamio"
  s.version     = Konamio::VERSION
  s.authors     = ["Tad Hosford"]
  s.email       = ["tad.hosford@gmail.com"]
  s.homepage    = "https://rthbound.github.io/konamio"
  s.summary     = "The Ruby Konami code gem."
  s.description = "Tell it which sequence to listen for and what to do when the sequence is received."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency "pay_dirt", "1.0.0"
  s.add_development_dependency "minitest"
  s.add_development_dependency "pry"
  s.add_development_dependency "rake"
  s.add_development_dependency "coveralls"
end
