# frozen_string_literal: true

require "forwardable"
require "xdg/pair"

module XDG
  # Provides state support.
  class State
    extend Forwardable

    HOME_PAIR = Pair["XDG_STATE_HOME", ".local/state"].freeze

    delegate %i[home directories all to_s to_str] => :combined

    def initialize home: Paths::Home, directories: Paths::Directory, environment: ENV
      @combined = Paths::Combined.new home.new(HOME_PAIR, environment),
                                      directories.new(Pair.new, environment)
      freeze
    end

    def inspect = "#<#{self.class}:#{object_id} #{self}>"

    private

    attr_reader :combined
  end
end
