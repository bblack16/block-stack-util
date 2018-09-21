require 'bblib/cli'
require_relative 'util'
require_relative 'cli/lib/constants'
require_relative 'cli/lib/shared'
require_relative 'cli/lib/parsers'

module BlockStack
  module CLI

    COMMAND = ARGV.shift
    COMMANDS = CLI.load_commands
    ARTIFACT_PATH = File.expand_path('../artifacts', __FILE__)

    if COMMAND && COMMANDS.include?(COMMAND.to_sym)
      begin
        require_relative "cli/commands/#{COMMAND}"
      rescue BBLib::OptsParserException => e
        puts "ERROR: #{e}"
        exit(1)
      end
    else
      STDERR.puts "Unknown command: #{COMMAND}\n\n" if COMMAND
      puts help_menu(COMMANDS)
    end

  end
end
