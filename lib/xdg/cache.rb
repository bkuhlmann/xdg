# frozen_string_literal: true

require "forwardable"
require "xdg/pair"

module XDG
  # Provides cache support.
  class Cache
    extend Forwardable

    HOME_PAIR = Pair["XDG_CACHE_HOME", ".cache"].freeze

    delegate %i[home directories all to_s to_str inspect] => :combined

    def initialize home: Paths::Home, directories: Paths::Directory, environment: ENV
      @combined = Paths::Combined.new home.new(HOME_PAIR, environment),
                                      directories.new(Pair.new, environment)
    end

    private

    attr_reader :combined
  end
end
