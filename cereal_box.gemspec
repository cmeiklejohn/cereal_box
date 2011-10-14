# encoding: UTF-8

$:.push File.expand_path("../lib", __FILE__)
require "cereal_box/version"

Gem::Specification.new do |s|
  s.name        = "cereal_box"
  s.version     = CerealBox::VERSION
  s.authors     = ["Christopher Meiklejohn"]
  s.email       = ["christopher.meiklejohn@gmail.com"]
  s.homepage    = "https://github.com/cmeiklejohn/cereal_box"
  s.summary     = %q{Serialization filters for active record.}
  s.description = %q{Serialization filters for active record.}

  s.rubyforge_project = "cereal_box"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('bundler')
  s.add_development_dependency('rspec') 
  s.add_development_dependency('guard') 
  s.add_development_dependency('guard-rspec')
  s.add_development_dependency('rake')
end
