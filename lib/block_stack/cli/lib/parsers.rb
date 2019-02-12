module BlockStack
  module CLI
    module Parsers

      INIT = BBLib::OptsParser.new do |o|
        o.usage 'Usage: blockstack init <APP_NAME> [options...]'
        o.command position: 0, name: 'app_name', desc: 'The name of the application'
        o.toggle '-h', '--help', desc: 'Displays help for the init command'
        o.string '-c', '--class-name', desc: 'The class name for the server. If left blank the app_name argument is used to generate this.'
        o.string '-o', '-f', '--output', desc: 'The output path to create the new project within.'
        o.toggle '--api', desc: 'Creates the shell of an API only BlockStack application (does not include UI artifacts)'
        o.string '-d', '--description', desc: 'Description of the application. Use for metadata.'
      end

      RUN = BBLib::OptsParser.new do |o|
        o.usage 'Usage: blockstack run [options...]'
        o.string('-p', '--port', desc: 'Override the set port.')
        o.string('-b', '--bind', desc: 'Override the address binding.')
        o.string('-e', '--environment', desc: 'Specify the environment to run.')
        o.toggle('-h', '--help', desc: 'Show help for this command.')
      end

      CREATE = BBLib::OptsParser.new do |o|
        o.usage 'Usage: blockstack create <SUB COMMAND> [options...]'
        o.at(0, name: :sub_command, desc: 'The type of object(s) to create.', default: 'help') { |x| x.to_sym }
      end

      CREATE_CONTROLLER = BBLib::OptsParser.new do |opts|
        opts.usage 'Usage: blockstack create controller <NAME> [options...]'
        opts.at(1, name: :name, desc: 'The name of the controller. Should not be plural, but casing does not matter.')
        opts.bool('-c', '--crud', default: false, desc: 'Create crud routes for a model matching this controller. The matching model must also exist or be created.')
        opts.toggle('-h', '--help', desc: 'Display help')
      end

      CREATE_MODEL = BBLib::OptsParser.new do |opts|
        opts.usage 'Usage: blockstack create model <NAME> [fields...] [options...]'
        opts.at(1, name: :name, desc: 'The name of the model. Should not be plural, but casing does not matter.')
        opts.symbol('--db', '--database', name: :database, desc: 'The name of the database to use. Uses :default if not specified.')
        opts.toggle('-h', '--help', desc: 'Display help')
      end

      CREATE_SCAFFOLD = BBLib::OptsParser.new do |opts|
        opts.usage 'Usage: blockstack create scaffold <NAME> [fields...<name:type>] [options...]'
        opts.at(1, name: :name, desc: 'The name of the model/controller. Should not be plural, but casing does not matter.')
        opts.bool('-c', '--crud', default: true, desc: 'Create crud routes for a model matching this controller. The matching model must also exist or be created.')
        opts.toggle('-h', '--help', desc: 'Display help')
      end

      EXEC = BBLib::OptsParser.new do |opts|
        opts.usage 'Usage: blockstack exec <script> [options...]'
        opts.at(0, name: :script, desc: 'The name of the script from the script directory to execute.')
        opts.toggle('--script-help', desc: 'Display help for the script command. -h and other flags are passed to the script itself.')
      end

    end
  end
end
