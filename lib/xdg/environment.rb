# frozen_string_literal: true

module XDG
  class Environment
    def initialize home: Paths::Standard, directories: Paths::Directory, environment: ENV
      @cache = Cache.new home: home, directories: directories, environment: environment
      @config = Config.new home: home, directories: directories, environment: environment
      @data = Data.new home: home, directories: directories, environment: environment
    end

    def cache_home
      cache.home
    end

    def config_home
      config.home
    end

    def config_dirs
      config.directories
    end

    def data_home
      data.home
    end

    def data_dirs
      data.directories
    end

    def inspect
      "#{cache.inspect} #{config.inspect} #{data.inspect}"
    end

    private

    attr_reader :cache, :config, :data
  end
end
