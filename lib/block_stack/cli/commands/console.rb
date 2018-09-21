# DESCRIPTION: Runs a pry or irb console for the current BlockStack server

module BlockStack
  module CLI
    app_path!

    opts = Parsers::RUN.parse

    load File.join(app_path, 'console.rb')
  end
end
