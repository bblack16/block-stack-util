# DESCRIPTION: Initializes the current directory as a BlockStack project

module BlockStack
  module CLI

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

    API_TEMPLATES = {
      'lib/server.rb' => File.join(ARTIFACT_PATH, 'api/server.rb.erb'),
      'Gemfile' => File.join(ARTIFACT_PATH, 'api/Gemfile.erb'),
      'run.rb' => File.join(ARTIFACT_PATH, 'api/run.rb.erb'),
      'console.rb' => File.join(ARTIFACT_PATH, 'shared/console.rb')
    }

    options = Parsers::INIT.parse(ARGV[1..-1])

    options.output = File.join(options.output || Dir.pwd, options.app_name.method_case)
    options.class_name = options.app_name.to_s.class_case unless options.class_name

    puts options

    gen_folders(options.output, API_FOLDERS)
    gen_folders(options.output, UI_FOLDERS) unless options.api?

    if options.api?
      puts 'Generating base files...'
      API_TEMPLATES.each do |file, template|
        render_template(template, File.join(options.output, file), options)
      end
    else

    end

  end
end
