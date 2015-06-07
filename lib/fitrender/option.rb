module Fitrender
  # A single configuration option
  class Option
    attr_accessor :name, :default, :description
    attr_writer :value

    # @param [String] name The name of the option
    # @param [Object] default The default value to use when no other value is set through the value= method
    # @param [String] description The human readable purpose of this option
    def initialize(name, default, description, value = nil)
      @name = name
      @default = default
      @description = description
      @value = value
    end

    def value
      @value || @default
    end

    def default?
      @value.nil?
    end

    def to_hash
      {
          'name' => name,
          'default' => default,
          'description' => description,
          'value' => value
      }
    end

    def self.from_hash(hash)
      value = hash['value'].eql?(hash['default']) ? nil : hash['value']
      self.new hash['name'], hash['default'], hash['description'], value
    end
  end
end