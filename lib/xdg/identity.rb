# frozen_string_literal: true

module XDG
  # Gem identity information.
  module Identity
    def self.name
      "xdg"
    end

    def self.label
      "XDG"
    end

    def self.version
      "3.1.0"
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
end
