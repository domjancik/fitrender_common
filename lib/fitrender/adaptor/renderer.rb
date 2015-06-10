module Fitrender
  module Adaptor
    class Renderer
      attr_accessor :id, :extension, :generator, :version

      # @param [String] id The id of the renderer, eg. Blender
      # @param [String] extension Supported file extension by this renderer, eg. blend
      # @param [Object] generator
      # @param [Object] version Optional. The version of the renderer available in the system.
      def initialize(id, extension, generator, version = 'Unspecified')
        @id = id
        @extension = extension
        @generator = generator
        generator.renderer = self unless generator.nil?
        @version = version
      end

      def to_hash
        {
            'id' => @id,
            'extension' => @extension,
            'version' => @version,
            'generator_options' => @generator.options_hashlist
        }
      end

      def self.from_hash(hash)
        generator = Fitrender::Adaptor::Generator.new
        generator.options_init_by_hashlist hash['generator_options']
        self.new hash['id'], hash['extension'], generator, hash['version']
      end

      def generate_submissions(scene)
        @generator.options_load_hash(scene.options)
        @generator.generate scene
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