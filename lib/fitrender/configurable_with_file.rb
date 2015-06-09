require 'psych'

module Fitrender
  module ConfigurableWithFile
    def config_save
      modified_options = {}
      @config.each_value do |option|
        modified_options[option.id] = option.value unless option.default?
      end

      if FileTest.exists? config_directory
        raise ConfigError.new('The config home is not a directory but a file') unless FileTest.directory? config_directory
      else
        Dir.mkdir config_directory
      end

      File.open(config_filename, 'w') do |file|
        puts Psych.dump(modified_options)
        file.write(Psych.dump(modified_options))
      end
    end

    def config_load
      filename = config_filename
      if FileTest.file? filename
        @modified_options = Psych.load_file(filename)
      end
    end

    def option_load(name)
      return if @modified_options.nil?
      option_set_value(name, @modified_options[name]) if @modified_options.has_key? name
    end

    def config_directory
      'config'
    end

    def config_filename
      # TODO configurable config location, so meta
      "#{config_directory}/#{Fitrender::Utils.underscore(self.class.to_s)}.yml"
    end

    include Fitrender::Configurable
  end
end
