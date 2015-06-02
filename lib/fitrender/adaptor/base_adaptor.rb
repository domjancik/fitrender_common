module Fitrender
  module Adaptor
    class BaseAdaptor
      METHODS_TO_IMPLEMENT = [
          :scene_submit,
          :job_status,
          :job_delete,
          :config_overview,
          :config_set,
          :available?,
          :nodes,
          :node
      ]

      # TODO: Settings define method
      # TODO: Default settings saving/retrieval using ENV Vars
      # TODO: Settings define method can take blocks to do for save: load:

      def initialize
        @settings = {}
        @renderers = []
      end

      ### Interface testing

      def methods_to_implement
        interface_methods = Array.new(METHODS_TO_IMPLEMENT)
        instance_methods = self.class.instance_methods false

        instance_methods.each do |method|
          interface_methods.delete method
        end

        interface_methods
      end

      def implements_all_methods?
        methods_to_implement.empty?
      end

      ### Scene submission

      # Submit a new scene
      # @return [Array] array of internal job ids
      # @param [Fitrender::Scene] scene
      def scene_submit(scene)
        raise Fitrender::InterfaceNotImplementedError
      end

      ### Job administration

      def job_status(job_id)
        raise Fitrender::InterfaceNotImplementedError
      end

      def job_delete(job_id)
        raise Fitrender::InterfaceNotImplementedError
      end

      ### Configuration

      def add_config(name, *args)

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

      # List nodes in the pool/cluster along with basic info
      # @return [Array] Array of hashes for each node. Each hash has an :id, :state and a limited amount of other attributes in :attributes. State is one of Fitrender::Adaptor::States::NODE_STATES
      def nodes
        raise Fitrender::InterfaceNotImplementedError
      end

      # Get all available info about the given node
      # @return [Hash] A hash containing an :id, :state and other attributes in :attributes. State is one of Fitrender::Adaptor::States::NODE_STATES
      def node(node_id)
        raise Fitrender::InterfaceNotImplementedError
      end

      ### Adaptor feature infos

      # Get various info about feature support in hash format
      def features
        {
            supported_renderers: feature_renderers,
            file_transfer_support: feature_file_transfer?
        }
      end

      def add_renderer(renderer)
        @renderers << renderer
      end

      def feature_renderers
        @renderers.inject([]) { |acc, renderer| acc << renderer.to_hash }
      end

      def feature_file_transfer?
        raise Fitrender::InterfaceNotImplementedError
      end
    end
  end
end