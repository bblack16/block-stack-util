module BlockStack
  module CLI
    module Parsers

      INIT = BBLib::OptsParser.new do |o|
        o.usage 'Usage: block_stack init <APP_NAME> [options...]'
        o.command position: 0, name: 'app_name', desc: 'The name of the application', required: true
        o.toggle '-h', '--help', desc: 'Displays help for the init command'
        o.string '-c', '--class-name', desc: 'The class name for the server. If left blank the app_name argument is used to generate this.'
        o.string '-o', '-f', '--output', desc: 'The output path to create the new project within.'
        o.toggle '--api', desc: 'Creates the shell of an API only BlockStack application (does not include UI artifacts)'
      end

    end
  end
end
