module Fitrender
  class InterfaceNotImplementedError < NoMethodError
  end

  class BackendNotAvailableError < RuntimeError
  end

  class NotFoundError < RuntimeError
  end

  class SubmissionFailedError < RuntimeError
  end

  class RendererNotFoundError < NotFoundError
  end

  class OptionNotFoundError < NotFoundError
  end

  class FileNotFoundError < NotFoundError
  end

  class ConfigError < RuntimeError
  end
end