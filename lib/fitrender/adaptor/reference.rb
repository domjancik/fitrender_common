module Fitrender
  module Adaptor
    # Reference for implementing compute backend adaptors for FITRender
    class Reference
      # Submit a new scene
      # @return [Array] array of internal job ids
      # @param [Fitrender::Scene] scene
      def submit(scene)
        [ 0 ]
      end

      def status(job_id)

      end

      def delete(job_id)
        true
      end

      # Get an overview of configurable variabels of the compute backend
      # @return [Hash] Hash of configurable variables and values
      def config_overview
        { config_variable: config_value }
      end

      # Set a config variable in the backend
      def config_set(name, value)

      end

      # Get a list of supported renderers
      def supported_renderers

      end
    end
  end
end