# DESCRIPTION: Runs the current BlockStack server

module BlockStack
  module CLI
    app_path!

    opts = Parsers::RUN.parse
    
    load File.join(app_path, 'run.rb')
  end
end
