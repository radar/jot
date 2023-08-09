# frozen_string_literal: true

require_relative "lib/jot/version"

Gem::Specification.new do |spec|
  spec.name = "jot-helpers"
  spec.version = Jot::VERSION
  spec.authors = ["Ryan Bigg"]
  spec.email = ["me@ryanbigg.com"]

  spec.summary = "Provides helper methods for working with JSON Web Tokens (JWTs)"
  spec.description = "Provides helper methods for working with JSON Web Tokens (JWTs)"
  spec.homepage = "https://github.com/radar/jot"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/radar/jot"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_dependency "jwt", "~> 2"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "timecop"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
