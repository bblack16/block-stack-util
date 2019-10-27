# DESCRIPTION: Create different assets such as models or controllers

module BlockStack
  module CLI

    SUB_COMMANDS = load_commands(File.expand_path('../create', __FILE__))

    opts = Parsers::CREATE.parse

    if !opts[:help] || SUB_COMMANDS.include?(opts.sub_command)
      require_relative "create/#{opts.sub_command}"
    else
      require_relative 'create/help'
    end
  end
end
