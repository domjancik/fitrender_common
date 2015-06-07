module Fitrender
  module Configurable
    # TODO: Settings define method should take blocks for actions on save: load:
    # TODO: replace option/config_load/save with callbacks set from ConfigurableWithFile

    def initialize
      super

      @config = {}
      config_load if self.respond_to? :config_load
    end

    def option_add(name, default, description)
      @config[name] = Fitrender::Option.new name, default, description
      option_load(name) if self.respond_to? :option_load
    end

    def option_get(name)
      raise Fitrender::NotFoundError.new("Option #{name}") unless @config.has_key? name
      @config[name]
    end

    def option_value(name)
      option_get(name).value
    end

    def option_set_value(name, value)
      option = option_get name
      option.value = value
      config_save if self.respond_to? :config_save
    end

    def options_list
      # TODO rewrite to tuse key, value
      @config.inject([]) { |a, option| a << option[1] }
    end
  end
end
