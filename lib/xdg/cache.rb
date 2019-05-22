# frozen_string_literal: true

require "forwardable"

module XDG
  class Cache
    extend Forwardable

    HOME_PAIR = Pair.new("XDG_CACHE_HOME", ".cache").freeze

    delegate %i[home directories all] => :combined

    def initialize home: Paths::Standard, directories: Paths::Directory, environment: ENV
      @combined = Paths::Combined.new home.new(HOME_PAIR, environment),
                                      directories.new(Pair.new, environment)
    end

    private

    attr_reader :combined
  end
end
