# DESCRIPTION: Display information about the current project (if called within a BlockStack app directory)

module BlockStack
  module CLI
    puts app_metadata.to_yaml
  end
end
