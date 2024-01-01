# frozen_string_literal: true

require "forwardable"
require "xdg/pair"

module XDG
  # Provides data support.
  class Data
    extend Forwardable

    HOME_PAIR = Pair["XDG_DATA_HOME", ".local/share"].freeze
    DIRS_PAIR = Pair["XDG_DATA_DIRS", "/usr/local/share:/usr/share"].freeze

    delegate %i[home directories all to_s to_str] => :combined

    def initialize home: Paths::Home, directories: Paths::Directory, environment: ENV
      @combined = Paths::Combined.new home.new(HOME_PAIR, environment),
                                      directories.new(DIRS_PAIR, environment)
    end

    def inspect = "#<#{self.class}:#{object_id} #{self}>"

    private

    attr_reader :combined
  end
end
