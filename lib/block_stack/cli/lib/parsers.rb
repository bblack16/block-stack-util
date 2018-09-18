module BlockStack
  module CLI
    module Parsers

      INIT = BBLib::OptsParser.new do |o|
        o.usage 'Usage: block_stack init <APP_NAME> [options...]'
        o.command position: 0, name: 'app_name', desc: 'The name of the application', default: 'help'
        o.toggle '-h', '--help', desc: 'Displays help for the init command'
        o.string '-c', '--class-name', desc: 'The class name for the server. If left blank the app_name argument is used to generate this.'
        o.string '-o', '-f', '--output', desc: 'The output path to create the new project within.'
        o.toggle '--api', desc: 'Creates the shell of an API only BlockStack application (does not include UI artifacts)'
      end

      CREATE = BBLib::OptsParser.new do |o|
        o.usage 'Usage: block_stack create <SUB COMMAND> [options...]'
        o.at(0, name: :sub_command, desc: 'The type of object(s) to create.', default: 'help') { |x| x.to_sym }
      end

      CREATE_CONTROLLER = BBLib::OptsParser.new.tap do |opts|
        opts.usage 'Usage: block_stack create controller <NAME> [options...]'
        opts.at(1, name: :name, desc: 'The name of the controller. Should not be plural, but casing does not matter.')
        opts.toggle('-h', '--help', desc: 'Display help')
      end

      CREATE_MODEL = BBLib::OptsParser.new.tap do |opts|
        opts.usage 'Usage: block_stack create model <NAME> [fields...] [options...]'
        opts.at(1, name: :name, desc: 'The name of the model. Should not be plural, but casing does not matter.')
        opts.toggle('-h', '--help', desc: 'Display help')
      end

    end
  end
end
