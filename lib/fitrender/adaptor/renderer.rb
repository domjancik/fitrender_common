module Fitrender
  module Adaptor
    class Renderer
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
            name: @name,
            extension: @extension,
            version: @version
        }
      end

      def generate_submissions(scene)
        @generator.generate scene
      end
    end
  end
end