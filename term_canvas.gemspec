lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "term_canvas/version"

Gem::Specification.new do |spec|
  spec.name          = "term_canvas"
  spec.version       = TermCanvas::VERSION
  spec.authors       = ["kthatoto"]
  spec.email         = ["kthatoto@gmail.com"]

  spec.summary       = %q{Wrapper library for curses of ruby}
  spec.description   = %q{Wrapper library for curses of ruby. You can handle colors easily.}
  spec.homepage      = "https://github.com/kthatoto/term_canvas"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "curses"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
