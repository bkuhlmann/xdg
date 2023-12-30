# frozen_string_literal: true

require "forwardable"
require "pathname"

module XDG
  module Paths
    # A XDG home path.
    class Home
      extend Forwardable

      KEY = "HOME"

      delegate %i[key value] => :pair

      def initialize pair, environment = ENV
        @pair = pair
        @environment = environment
      end

      def default = expand String(value)

      def dynamic = String(environment[key]).then { |path| path.empty? ? default : expand(path) }

      def to_s = [pair.key, dynamic].compact.join XDG::DELIMITER

      alias to_str to_s

      def inspect = "#<#{self.class}:#{object_id} #{self}>"

      private

      attr_reader :pair, :environment

      def expand(path) = home.join(path).expand_path

      def home = Pathname environment.fetch(KEY)
    end
  end
end
