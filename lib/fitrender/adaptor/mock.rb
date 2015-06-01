require 'fitrender/adaptor'

module Fitrender
  module Adaptor
    # Mock implementation of a FITRender compute backend adaptor
    class Mock < BaseAdaptor
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

      def available?
        true
      end

      ### Adaptor feature infos

      def feature_file_transfer?
        true
      end

      def feature_renderers

      end
    end
  end
end