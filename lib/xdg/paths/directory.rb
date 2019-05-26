# frozen_string_literal: true

require "pathname"

module XDG
  module Paths
    # A collection of XDG directories.
    class Directory
      DELIMITER = ":"

      def initialize pair, environment = ENV
        @pair = pair
        @environment = environment
      end

      def default
        paths.split(DELIMITER).map(&method(:expand))
      end

      def dynamic
        environment.fetch(pair.key, paths).split(DELIMITER).uniq.map(&method(:expand))
      end

      private

      attr_reader :pair, :environment

      def paths
        String pair.value
      end

      def expand path
        Pathname(path).expand_path
      end
    end
  end
end
