module Fitrender
  module Adaptor
    module States
      JOB_STATE_IDLE = 'idle'
      JOB_STATE_RUNNING = 'running'
      JOB_STATE_COMPLETED = 'completed'
      JOB_STATE_FAILED = 'failed'
      JOB_STATE_OTHER = 'other'

      NODE_STATES = [
        JOB_STATE_IDLE,
        JOB_STATE_RUNNING,
        JOB_STATE_COMPLETED,
        JOB_STATE_FAILED,
        JOB_STATE_OTHER
      ]
    end
  end
end