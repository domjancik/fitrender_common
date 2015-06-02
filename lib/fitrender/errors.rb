module Fitrender
  class InterfaceNotImplementedError < NoMethodError

  end

  class BackendNotAvailableError < RuntimeError

  end

  class NotFoundError < RuntimeError

  end
end