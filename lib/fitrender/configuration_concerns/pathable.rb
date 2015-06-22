module Fitrender
  module ConfigurationConcerns
    module Pathable
      OPTION_RENDER_PATH_NAME = 'render_path'
      OPTION_LOG_PATH_NAME = 'log_path'
      OPTION_SCENE_PATH_NAME = 'scene_path'
      OPTION_OUT_PATH_NAME = 'scene_path'

      # TODO move to some helper class, is a general method
      def env_or_default(envname, default)
        ENV[envname] || default
      end

      def initialize
        super

        option_add OPTION_RENDER_PATH_NAME, env_or_default('FITRENDER_RENDER_PATH', 'Set me or set FITRENDER_RENDER_PATH in ENV and restart the app'), 'The location for finished renders'
        option_add OPTION_LOG_PATH_NAME, env_or_default('FITRENDER_LOG_PATH', 'Set me or set FITRENDER_LOG_PATH in ENV and restart the app'), 'The location for log files'
        option_add OPTION_SCENE_PATH_NAME, env_or_default('FITRENDER_SCENE_PATH', 'Set me or set FITRENDER_SCENE_PATH in ENV and restart the app'), 'The location for scene uploads'
        option_add OPTION_OUT_PATH_NAME, env_or_default('FITRENDER_OUT_PATH', 'Set me or set FITRENDER_OUT_PATH in ENV and restart the app'), 'The location for program output files'
      end

      # Shortcut methods
      def render_path
        option_value OPTION_RENDER_PATH_NAME
      end

      def log_path
        option_value OPTION_LOG_PATH_NAME
      end

      def scene_path
        option_value OPTION_SCENE_PATH_NAME
      end

      def out_path
        option_value OPTION_OUT_PATH_NAME
      end
    end
  end
end
