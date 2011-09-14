# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "./lib/version"

Gem::Specification.new do |s|
  s.name        = "project_err"
  s.version     = ProjectErr::VERSION
  s.authors     = ["Jonah Williams"]
  s.email       = ["jonah@carbonfive.com"]
  s.homepage    = "www.carbonfive.com"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency 'polyglot'
  s.add_runtime_dependency 'treetop'
  s.add_runtime_dependency 'thor'
end
