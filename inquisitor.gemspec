# -*- encoding: utf-8 -*-
require File.expand_path("../lib/inquisitor/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "inquisitor"
  s.version     = Inquisitor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = []
  s.email       = []
  s.homepage    = "http://github.com/tissak/inquisitor"
  s.summary     = "Scour projects for gem status"
  s.description = "Will look for Gemfile.lock files in a path and record gem status"

  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "~>2.6"
  s.add_dependency "thor"
  s.add_dependency "json"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_paths = ["lib"]
end

