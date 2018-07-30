require 'erb'
require 'fileutils'

module BlockStack
  module CLI

    options = Parsers::INIT.parse(ARGV[2..-1])


    options.app_name = ARGV[2].to_s.class_case
    options.output = File.join(options.output || Dir.pwd, options.app_name.method_case)
    options.class_name = options.app_name.to_s.class_case unless options.class_name

    puts options
    exit

    ARTIFACT_PATH = File.expand_path('../../../artifacts', __FILE__)

    API_FOLDERS = [
      'lib',
      'app',
      'app/models',
      'app/controllers',
      'config'
    ]

    UI_FOLDERS = [
      'app/javascript',
      'app/stylesheets',
      'app/views'
    ]

    TEMPLATES = {
      'lib/server.rb' => File.join(ARTIFACT_PATH, 'api/server.rb.erb'),
      'Gemfile' => File.join(ARTIFACT_PATH, 'shared/Gemfile'),
      'run.rb' => File.join(ARTIFACT_PATH, 'shared/run.rb.erb'),
      'console.rb' => File.join(ARTIFACT_PATH, 'shared/console.rb')
    }

    API_FOLDERS.each do |path|
      directory = File.join(options.path, path)
      if Dir.exist?(directory)
        log("Directory already exists. Skipping: #{directory}", :info)
      else
        log("Creating directory #{directory}", :info)
        FileUtils.mkpath(directory)
      end
    end

    @app_name = options.app_name
    @app_class = options.app_class
    TEMPLATES.each do |path, template|
      output_file = File.join(options.path, path)
      if File.exist?(output_file)
        log("File already exists: #{output_file}. Skipping...", :warn)
        next
      end
      ERB.new(File.read(template)).result(binding).to_file(output_file, mode: 'w')
    end

  end
end
