module BlockStack
  module CLI

    def self.app_path
      path = Dir.pwd
      path.split('/').reverse.each do |part|
        return path if File.exist?(File.join(path, 'run.rb'))
        path.gsub!(/\/#{part}$/)
      end
      nil
    end

    def self.app_path!
      return if app_path
      BBLib.logger.warn("Could not locate a valid block_stack application. Be sure to run this command within the directory of your app.")
      exit(1)
    end

    def self.load_commands(path = File.expand_path('../../commands', __FILE__))
      BBLib.scan_files(path, '*.rb').hmap do |file|
        [
          file.file_name(false).to_sym,
          File.read(file).scan(/\#\s?DESCRIPTION\:\s?(.*)/).flatten.first.to_s
        ]
      end
    end

    def self.default_options
      {
        block_stack_version: BLOCK_STACK_VERSION
      }
    end

    def self.logo
      %"
   ____  _            _     _____ _             _
  |  _ \\| |          | |   / ____| |           | |
  | |_) | | ___   ___| | _| (___ | |_ __ _  ___| | __
  |  _ <| |/ _ \\ / __| |/ /\\___ \\| __/ _` |/ __| |/ /
  | |_) | | (_) | (__|   < ____) | || (_| | (__|   <
  |____/|_|\\___/ \\___|_|\\_\\_____/ \\__\\__,_|\\___|_|\\_\\
  \\_________________ VERSION #{BBLib::Console.colorize(BLOCK_STACK_VERSION, :light_green)} _________________/
      "
    end

    def self.help_menu(commands)
      max = commands.keys.map(&:to_s).map(&:size).max + 3
      logo + "\n" +
      "Usage: block_stack <command> [options...]" +
      "\n\nCOMMANDS:\n\n\t" +
      commands.map { |command, desc| "#{command.to_s.ljust(max, ' ')}#{desc}"}.join("\n\t")
    end

    def self.log(message, severity = :info)
      puts "[#{severity.to_s.upcase.to_color(severity)}] #{message}"
    end

    def self.gen_folders(base_path, dirs)
      dirs.each do |dir|
        path = File.join(base_path, dir)
        if Dir.exist?(path)
          log("Directory already exists. Skipping: #{path}", :info)
        else
          log("Creating directory #{path}", :info)
          FileUtils.mkpath(path)
        end
      end
    end

    def self.render_template(template_file, output, opts = {})
      require 'erb' unless defined?(ERB)
      if !File.exist?(output) || opts.delete(:overwrite)
        @options = opts.merge(default_options)
        log("Creating template for #{output.file_name} (#{template_file.file_name(false)})", :info)
        ERB.new(File.read(template_file)).result(opts.delete(:binding) || binding).to_file(output, mode: 'w')
      else
        log("Skipping template #{template_file} since the file already exists at #{output}", :warn)
      end
    end

    def self.artifact(path)
      File.join(File.expand_path('../../artifacts', __FILE__), path)
    end

  end
end
