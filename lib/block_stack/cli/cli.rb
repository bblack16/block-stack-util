# require 'bblib/cli'
require_relative '../../../../bblib/lib/bblib/cli'
require_relative '../util'
require_relative 'lib/constants'
require_relative 'lib/shared'
require_relative 'lib/parsers'

module BlockStack
  module CLI

    COMMANDS = CLI.load_commands
    ARTIFACT_PATH = File.expand_path('../artifacts', __FILE__)

    if ARGV.first && COMMANDS.include?(ARGV.first.to_sym)
      begin
        require_relative "commands/#{ARGV.first}"
      rescue BBLib::OptsParserException => e
        puts "ERROR: #{e}"
        exit(1)
      end
    else
      STDERR.puts "Unknown command: #{ARGV.first}\n\n" if ARGV.first
      puts help_menu(COMMANDS)
    end

  end
end
