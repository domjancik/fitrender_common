module Fitrender
  module Adaptor
    class Node
      attr_reader :id, :attributes, :state

      def initialize(id, state = Fitrender::Adaptor::States::NODE_STATE_OTHER, attributes = {})
        @id = id
        @attributes = attributes
        @state = state
      end

      # Serialize to a hash
      def to_hash
        {
            id: id,
            state: state,
            attributes: attributes
        }
      end

      # Deserialize from a hash
      def self.from_hash(hash)
        id = hash[:id] || hash['id']
        state = hash[:state] || hash['state']
        attributes = hash[:attributes] || hash['attributes']
        new id, state, attributes
      end
    end
  end
end