# frozen_string_literal: true

require "forwardable"
require "pathname"

module XDG
  module Paths
    # A XDG home path.
    class Standard
      extend Forwardable

      HOME_KEY = "HOME"

      delegate %i[key value] => :pair

      def initialize pair, environment = ENV
        @pair = pair
        @environment = environment
      end

      def default
        expand_home_for String(value)
      end

      def dynamic
        String(environment[key]).then { |path| path.empty? ? default : expand_home_for(path) }
      end

      private

      attr_reader :pair, :environment

      def home
        Pathname environment.fetch(HOME_KEY)
      end

      def expand_home_for path
        home.join(path).expand_path
      end
    end
  end
end
