# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "konamio/version"

Gem::Specification.new do |s|
  s.name        = "konamio"
  s.version     = Konamio::VERSION
  s.authors     = ["Tad Hosford"]
  s.email       = ["tad.hosford@gmail.com"]
  s.homepage    = "http://ea.rthbound.com/konamio"
  s.summary     = "The Ruby Konami code gem."
  s.description = "Use Konamio in your Ruby or Rails console and be prompted to enter the Konami code. Pass in a block to tell Konamio what to do when the code has been entered. Konamio can optionally be told to listen for any ASCII based sequence (it's not limited to the konami code)."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency "pay_dirt", "~> 1.0.0"
  s.add_development_dependency "minitest"
  s.add_development_dependency "pry"
  s.add_development_dependency "rake"
  s.add_development_dependency "coveralls"
end
