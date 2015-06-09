module Fitrender
  module Adaptor
    class Scene
      attr_accessor :renderer_id, :path, :options

      def initialize(*args)
        args = Fitrender::Utils.extract_options(args)
        args.each do |key, value|
          self.send("#{key}=", value)
        end
      end

      def option_value(option_id)
        options[option_id] || options[option_id.to_s]
      end
    end
  end
end
