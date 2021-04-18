# frozen_string_literal: true

module XDG
  class Environment
    def initialize home: Paths::Home, directories: Paths::Directory, environment: ENV
      @cache = Cache.new home: home, directories: directories, environment: environment
      @config = Config.new home: home, directories: directories, environment: environment
      @data = Data.new home: home, directories: directories, environment: environment
    end

    def cache_home = cache.home

    def config_home = config.home

    def config_dirs = config.directories

    def data_home = data.home

    def data_dirs = data.directories

    def inspect = "#{cache.inspect} #{config.inspect} #{data.inspect}"

    private

    attr_reader :cache, :config, :data
  end
end
