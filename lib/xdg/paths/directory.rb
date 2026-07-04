# frozen_string_literal: true

module XDG
  module Paths
    # A collection of XDG directories.
    class Directory < Any
      DELIMITER = ":"

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

      def key = String pair.key

      def value = String pair.value
    end
  end
end
