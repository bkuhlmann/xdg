# frozen_string_literal: true

module XDG
  module Paths
    # A collection of XDG directories.
    class Directory
      DELIMITER = ":"

      def initialize pair, environment = ENV
        @pair = pair
        @environment = environment
        freeze
      end

      def default = value.split(DELIMITER).map { |path| expand path }

      def dynamic
        String(environment[key]).then { |env_value| env_value.empty? ? value : env_value }
                                .split(DELIMITER)
                                .uniq
                                .map { |path| expand path }
      end

      def to_s = [key, dynamic.join(DELIMITER)].reject(&:empty?).join XDG::DELIMITER

      alias to_str to_s

      def inspect
        pairs = to_s
        type = self.class

        pairs.empty? ? "#<#{type}:#{object_id}>" : "#<#{type}:#{object_id} #{self}>"
      end

      private

      attr_reader :pair, :environment

      def key = String pair.key

      def value = String pair.value

      def expand(path) = Pathname(path).expand_path
    end
  end
end
