module Fitrender
  module Adaptor
    # A class that dictates how to generate jobs based on a given scene.
    # Used in a Fitrender::Adaptor::Renderer object
    class Generator
      include Fitrender::Configurable

      attr_accessor :renderer

      # Generate submissions scripts for a given scene
      # @param [Fitrender::Adaptor::Scene] scene
      # @return [Array] A list of executable submissions scripts based on the scene and its settings
      def generate(scene, adaptor)
        raise Fitrender::InterfaceNotImplementedError
      end
    end
  end
end
