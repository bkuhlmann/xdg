# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "xdg"
  spec.version = "9.1.0"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/xdg"
  spec.summary = "A XDG Base Directory Specification implementation."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/xdg/issues",
    "changelog_uri" => "https://alchemists.io/projects/xdg/versions",
    "homepage_uri" => "https://alchemists.io/projects/xdg",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "XDG",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/xdg"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.4"

  spec.files = Dir["*.gemspec", "lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
end
