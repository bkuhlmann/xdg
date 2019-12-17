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

      def default
        expand String(value)
      end

      def dynamic
        String(environment[key]).then { |path| path.empty? ? default : expand(path) }
      end

      def inspect
        [pair.key, dynamic].compact.join XDG::PAIR_DELIMITER
      end

      private

      attr_reader :pair, :environment

      def expand path
        home.join(path).expand_path
      end

      def home
        Pathname environment.fetch(KEY)
      end
    end
  end
end
