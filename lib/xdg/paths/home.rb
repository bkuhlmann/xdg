# frozen_string_literal: true

module XDG
  module Paths
    # A XDG home path.
    class Home < Any
      KEY = "HOME"

      def initialize pair, environment = ENV, default_key: KEY
        @default_key = default_key
        super(pair, environment)
      end

      protected

      def expand(path) = home.join(path).expand_path

      def home = Pathname environment.fetch(default_key)

      private

      attr_reader :default_key
    end
  end
end
