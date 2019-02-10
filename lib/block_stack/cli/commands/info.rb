# DESCRIPTION: Display information about the current project (if called within a BlockStack app directory)

module BlockStack
  module CLI

    puts app_info.to_yaml
  end
end
