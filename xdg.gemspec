# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "xdg"
  spec.version = "7.0.1"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://www.alchemists.io/projects/xdg"
  spec.summary = "Provides an implementation of the XDG Base Directory Specification."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/xdg/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/xdg/versions",
    "documentation_uri" => "https://www.alchemists.io/projects/xdg",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "XDG",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/xdg"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.2"

  spec.files = Dir["*.gemspec", "lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
end
