module BlockStack
  # Default logger is set to the BBLib logger
  def self.logger
    @logger ||= BBLib.logger
  end

  # Allow custom logger to be set
  def self.logger=(logger)
    @logger = logger
  end

  # Set the default level to warnings only
  logger.level = :warn
end
