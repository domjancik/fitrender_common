module Fitrender
  module Adaptor
    class Renderer
      include Fitrender::Configurable

      attr_accessor :id, :extension, :version
      attr_reader :generator

      def initialize
        super

        @id = 'Renderer'
        @extension = 'ext'
        @generator = nil
        @version = 'Unknown'
      end

      def generator=(generator)
        @generator = generator
        generator.renderer = self unless generator.nil?
      end

      def to_hash
        {
            'id' => @id,
            'extension' => @extension,
            'version' => @version,
            'generator_options' => @generator.options_hashlist,
            'renderer_options' => options_hashlist
        }
      end

      def self.from_hash(hash)
        generator = Fitrender::Adaptor::Generator.new
        generator.options_init_by_hashlist hash['generator_options']

        renderer = self.new
        renderer.id = hash['id']
        renderer.extension = hash['extension']
        renderer.generator = generator
        renderer.version = hash['version']
        renderer.options_init_by_hashlist hash['renderer_options']

        renderer
      end

      def generate_submissions(scene, adaptor)
        @generator.options_load_hash(scene.options)
        @generator.generate scene, adaptor
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