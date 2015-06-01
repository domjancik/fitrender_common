require 'fitrender/errors'

module Fitrender
  module Adaptor
    class BaseAdaptor
      # TODO: Settings define method
      # TODO: Default settings saving/retrieval using ENV Vars
      # TODO: Settings define method can take blocks to do for save: load:

      def initialize
        @settings = {}
      end

      def add_config(name, *args)

      end

      # Submit a new scene
      # @return [Array] array of internal job ids
      # @param [Fitrender::Scene] scene
      def submit(scene)
        raise Fitrender::InterfaceNotImplementedError
      end

      def status(job_id)
        raise Fitrender::InterfaceNotImplementedError
      end

      def delete(job_id)
        raise Fitrender::InterfaceNotImplementedError
      end

      # Get an overview of configurable variabels of the compute backend
      # @return [Hash] Hash of configurable variables and values
      def config_overview
        raise Fitrender::InterfaceNotImplementedError
      end

      # Set a config variable in the backend
      def config_set(name, value)
        raise Fitrender::InterfaceNotImplementedError
      end

      ### Status

      def available?
        raise Fitrender::InterfaceNotImplementedError
      end

      def available!
        raise Fitrender::BackendNotAvailableError unless available?
      end

      # List nodes in the pool/cluster
      def nodes
        raise Fitrender::InterfaceNotImplementedError
      end

      ### Adaptor feature infos

      # Get various info about feature support
      def features
        {
            supported_renderers: feature_renderers,
            file_transfer_support: feature_file_transfer?
        }
      end

      def feature_renderers
        raise Fitrender::InterfaceNotImplementedError
      end

      def feature_file_transfer?
        raise Fitrender::InterfaceNotImplementedError
      end
    end
  end
end