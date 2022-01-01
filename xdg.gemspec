# frozen_string_literal: true

require_relative "lib/xdg/identity"

Gem::Specification.new do |spec|
  spec.name = XDG::Identity::NAME
  spec.version = XDG::Identity::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://www.alchemists.io/projects/xdg"
  spec.summary = "Provides an implementation of the XDG Base Directory Specification."
  spec.license = "Hippocratic-3.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/xdg/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/xdg/versions",
    "documentation_uri" => "https://www.alchemists.io/projects/xdg",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/xdg"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.1"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths = ["lib"]
end
