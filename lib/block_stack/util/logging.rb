module BlockStack
  # Default logger is set to the BBLib logger
  def self.logger
    @logger ||= BBLib.logger
  end

  # Allow custom logger to be set
  def self.logger=(logger)
    @logger = logger
  end
end
