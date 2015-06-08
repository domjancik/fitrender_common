module Fitrender
  module Adaptor
    class Renderer
      attr_accessor :name, :extension, :generator, :version

      # @param [String] name The name of the renderer, eg. Blender
      # @param [String] extension Supported file extension by this renderer, eg. blend
      # @param [Object] generator
      # @param [Object] version Optional. The version of the renderer available in the system.
      def initialize(name, extension, generator, version = 'Unspecified')
        @name = name
        @extension = extension
        @generator = generator
        @version = version
      end

      def to_hash
        {
            'name' => @name,
            'extension' => @extension,
            'version' => @version,
            'generator_options' => @generator.options_hashlist
        }
      end

      def self.from_hash(hash)
        generator = Fitrender::Adaptor::Generator.new
        generator.options_init_by_hashlist hash['generator_options']
        self.new hash['name'], hash['extension'], generator, hash['version']
      end

      def generate_submissions(scene)
        @generator.generate scene, settings
      end

      def generator_options
        @generator.options_list
      end

      # Serialize all settings into a hash
      def settings
        # TODO
        {}
      end
    end
  end
end