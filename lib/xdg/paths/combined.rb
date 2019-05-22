# frozen_string_literal: true

require "pathname"

module XDG
  module Paths
    # The combined home and directory paths.
    class Combined
      def initialize initial_home, initial_directories
        @initial_home = initial_home
        @initial_directories = initial_directories
      end

      def home
        initial_home.dynamic
      end

      def directories
        initial_directories.dynamic
      end

      def all
        directories.prepend home
      end

      private

      attr_reader :initial_home, :initial_directories
    end
  end
end
