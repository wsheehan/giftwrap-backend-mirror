module BraintreeHelper
  
  class SuccessResult
    def self.success?
      true
    end
  end

  class FailureResult
    def self.success?
      false
    end
  end
end