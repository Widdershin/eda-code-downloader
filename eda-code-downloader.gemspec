# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "eda-code-downloader"
  spec.version       = "0.0.1"
  spec.authors       = ["Nick Johnstone"]
  spec.email         = ["ncwjohnstone@gmail.com"]

  spec.summary       = %q{A tool to clone all of your Dev Academy work for you.}
  spec.description   = %q{eda-code-downloader is a command line tool that will clone all of the work that you did at Dev Academy. It handles cloning from branches with names like Nick_and_Hannah so you will have both your solo and pairing work. You can also specify master as the branch to download all the challenges for a cohort.}
  spec.homepage      = "https://github.com/Widdershin/eda-code-downloader"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = 'eda-code-downloader'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", '~> 3.2', ">= 3.2.0"
  spec.license = "MIT"
end
