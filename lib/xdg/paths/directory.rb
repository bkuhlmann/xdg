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
        value.split(DELIMITER).map(&method(:expand))
      end

      def dynamic
        String(environment[key]).then { |env_value| env_value.empty? ? value : env_value }
                                .split(DELIMITER)
                                .uniq
                                .map(&method(:expand))
      end

      def inspect
        [key, dynamic.join(DELIMITER)].reject(&:empty?).join XDG::PAIR_DELIMITER
      end

      private

      attr_reader :pair, :environment

      def key
        String pair.key
      end

      def value
        String pair.value
      end

      def expand path
        Pathname(path).expand_path
      end
    end
  end
end
