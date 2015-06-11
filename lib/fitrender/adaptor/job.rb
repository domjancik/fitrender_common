module Fitrender
  module Adaptor
    class Job
      attr_reader :id, :name, :path

      def initialize(*args)
        args = Fitrender::Utils.extract_options(args)
        @id = args[:id]
        @name = args[:name]
        @path = args[:path]
      end

      def to_hash
        {
            'id' => id,
            'name' => name,
            'path' => path
        }
      end
    end
  end
end
