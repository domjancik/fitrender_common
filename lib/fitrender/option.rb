module Fitrender
  # A single configuration option
  class Option
    attr_accessor :id, :default, :description
    attr_writer :value

    # @param [String] id The id of the option
    # @param [Object] default The default value to use when no other value is set through the value= method
    # @param [String] description The human readable purpose of this option
    def initialize(id, default, description, value = nil)
      @id = id
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
          'id' => id,
          'default' => default,
          'description' => description,
          'value' => value
      }
    end

    def self.from_hash(hash)
      value = hash['value'].eql?(hash['default']) ? nil : hash['value']
      self.new hash['id'], hash['default'], hash['description'], value
    end

    def ==(o)
      o.class == self.class && o.state == state
    end

    alias_method :eql?, :==

    protected

    def state
      [ @id, @default, @description, @value ]
    end
  end
end