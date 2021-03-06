module Fitrender
  module Configurable
    # TODO: Settings define method should take blocks for actions on save: load:
    # TODO: replace option/config_load/save with callbacks set from ConfigurableWithFile
    # TODO: DSL methods so adding of options can be done outside of the initialize method
    # TODO: Support for reading via object.option_key and setting via object.option_key= using method_missing

    def initialize
      super

      @config = {}
      config_load if self.respond_to? :config_load
    end

    def option_add(name, default, description)
      option_add_object Fitrender::Option.new name, default, description
    end

    def option_get(name)
      raise Fitrender::OptionNotFoundError.new("Option #{name}") unless @config.has_key? name
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
      # TODO rewrite to use key, value
      @config.inject([]) { |a, option| a << option[1] }
    end

    # Serialize all options into a list of hashes
    def options_hashlist
      @config.inject([]) { |a, option| a << option[1].to_hash }
    end

    # Initialize options from the given hashlist
    def options_init_by_hashlist(hashlist)
      hashlist.each do |option|
        option_add_object Fitrender::Option.from_hash(option)
      end
    end

    # Load option values from the given hash
    def options_load_hash(hash)
      unless hash.nil?
        hash.each do |key, value|
          option_set_value key, value
        end
      end
    end

    private

    def option_add_object(option)
      id = option.id
      @config[id] = option
      option_load(id) if self.respond_to? :option_load
    end
  end
end
