module Fitrender
  module ConfigurationConcerns
    module Framable
      OPTION_FRAMES_NAME = 'frames'

      def initialize
        super
        option_add OPTION_FRAMES_NAME, '1', 'The frames to render, separate by commas, use dashes to define range (eg. 1,3-5,8)'
      end

      # Helper method to parse the frames setting
      def frames
        frames_setting = option_value OPTION_FRAMES_NAME
        (frames_setting.split(',').inject([]) do |arr, frame_range|
          (parse_frame_range frame_range).each { |frame| arr << frame }
          arr
        end).uniq
      end

      protected

      def parse_frame_range(frame_range_string)
        begin
          [Integer(frame_range_string)]
        rescue ArgumentError
          range = frame_range_string.split('-')
          Integer(range[0])..Integer(range[1])
        end
      end
    end
  end
end
