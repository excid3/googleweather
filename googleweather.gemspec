# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "googleweather/version"

Gem::Specification.new do |s|
  s.name        = "googleweather"
  s.version     = Googleweather::VERSION
  s.authors     = ["brookemckim"]
  s.email       = ["brooke.mckim@gmail.com"]
  s.homepage    = "http://github.com/brookemckim/googleweather/"
  s.summary     = %q{Google Weather API Client}
  s.description = %q{Client for the undocumented Google Weather API}

  s.rubyforge_project = "googleweather"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "minitest"
  s.add_development_dependency "mocha"
  s.add_development_dependency "vcr"  
  s.add_development_dependency "minitest-debugger"  
  s.add_development_dependency "guard-minitest"
  s.add_development_dependency "webmock"
  
  s.add_runtime_dependency "nokogiri"
end
