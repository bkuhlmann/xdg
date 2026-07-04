# frozen_string_literal: true

require "forwardable"

module XDG
  module Paths
    # A XDG any path.
    class Any
      extend Forwardable

      delegate %i[key value] => :pair

      def initialize pair, environment = ENV
        @pair = pair
        @environment = environment
        freeze
      end

      def default = expand String(value)

      def dynamic = String(environment[key]).then { |path| path.empty? ? default : expand(path) }

      def to_s = [pair.key, dynamic].compact.join XDG::DELIMITER

      alias to_str to_s

      def inspect = "#<#{self.class}:#{object_id} #{self}>"

      protected

      attr_reader :pair, :environment

      def expand(path) = Pathname(path).then { path.empty? ? it : it.expand_path }
    end
  end
end
