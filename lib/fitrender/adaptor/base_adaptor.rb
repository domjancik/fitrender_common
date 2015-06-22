module Fitrender
  module Adaptor
    class BaseAdaptor
      METHODS_TO_IMPLEMENT = [
          :submit,
          :job_status,
          :job_delete,
          :options_list,
          :option_set_value,
          :option_get,
          :available?,
          :nodes,
          :node
      ]

      attr_accessor :renderers

      def initialize
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
      # @return [Array] array of Fitrender::Adaptor::Job (or similar) instances
      # @param [Fitrender::Adaptor::Scene] scene
      def submit(scene)
        raise Fitrender::InterfaceNotImplementedError
      end

      def detect_renderer(scene)
        renderer_name = scene.renderer_id
        renderer = @renderers.find { |renderer| renderer.id.eql? renderer_name }
        raise Fitrender::RendererNotFoundError unless renderer
        renderer
      end

      ### Job administration

      def job(job_id)
        {
            type: 'Job',
            id: job_id,
            state: job_state(job_id)
        }
      end

      def job_state(job_id)
        raise Fitrender::InterfaceNotImplementedError
      end

      def job_delete(job_id)
        raise Fitrender::InterfaceNotImplementedError
      end

      ### Configuration

      # From Configurable:
      # option_add
      # option_set
      # option_get
      # option_list

      ### Status

      def available?
        raise Fitrender::InterfaceNotImplementedError
      end

      # Make sure the backend is available.
      # Throws Fitrender::BackendNotAvailableError unless the backend is available
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

      def renderers
        @renderers.inject([]) { |acc, renderer| acc << renderer }
      end

      def renderer(renderer_id)
        renderer = @renderers.find { |renderer| renderer.id.eql?(renderer_id) }
        raise Fitrender::RendererNotFoundError.new(renderer_id) unless renderer
        renderer
      end

      protected

      # @param [Fitrender::Adaptor::Scene] scene
      # @return [Array] an array of submissions from the scene's renderer's generator
      def generate_submissions(scene)
        raise Fitrender::FileNotFoundError unless FileTest.file? scene.path
        arr = *(detect_renderer(scene).generate_submissions(scene, self))
        arr
      end
    end
  end
end