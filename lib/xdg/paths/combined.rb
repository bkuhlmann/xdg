# frozen_string_literal: true

require "pathname"

module XDG
  module Paths
    # The combined home and directory paths.
    class Combined
      def initialize initial_home, initial_directories
        @initial_home = initial_home
        @initial_directories = initial_directories
        freeze
      end

      def home = initial_home.dynamic

      def directories = initial_directories.dynamic

      def all = directories.prepend(*home)

      def to_s = [initial_home.to_s, initial_directories.to_s].reject(&:empty?).join " "

      alias to_str to_s

      def inspect = "#<#{self.class}:#{object_id} #{self}>"

      private

      attr_reader :initial_home, :initial_directories
    end
  end
end
