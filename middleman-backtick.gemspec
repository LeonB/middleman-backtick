# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-backtick"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Leon Bogaert"]
  s.email       = ["leonbogaert@gmail.com"]
  s.homepage    = "http://www.vanutsteen.nl"
  s.summary     = %q{backtick_code_blocks (like octopress') for middleman}
  # s.description = %q{A longer description of your extension}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 3.0.11"])

  # Additional dependencies
  # s.add_runtime_dependency("gem-name", "gem-version")
end
