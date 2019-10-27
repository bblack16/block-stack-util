# DESCRIPTION: Display information about the current project (if called within a BlockStack app directory)

module BlockStack
  module CLI
    options = Parsers::INFO.parse
    puts Formatter.format(options.format, app_metadata)
  end
end
