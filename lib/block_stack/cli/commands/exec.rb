# DESCRIPTION: Run a script from the application's script directory

module BlockStack
  module CLI

    def self.script_dir
      File.join(script_dir, 'scripts')
    end

    def self.scripts
      @scripts ||= BBLib.scan_files(script_dir, '*.rb').hmap do |file|
        [file.file_name(false), file]
      end
    end

    options = Parsers::EXEC.parse

    if options.script_help? || !options.script
      puts Parsers::EXEC.help
      print '-' * 20, '< Scripts >', '-' * 20, "\n\t"
      puts scripts.keys.join("\n\t")
      exit 0
    end

    if scripts[options.script]
      load_app_context
      load scripts[options.script]
    else
      log("Could not locatea matching script for #{script}", :warn)
      exit 1
    end
  end
end
