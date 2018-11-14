# DESCRIPTION: Initializes the current directory as a BlockStack project

module BlockStack
  module CLI

    API_FOLDERS = [
      'lib',
      'app',
      'app/models',
      'app/controllers',
      'config',
      'data'
    ]

    UI_FOLDERS = [
      'app/javascript',
      'app/stylesheets',
      'app/views'
    ]

    SHARED_TEMPLATES = {
      'run.rb' => artifact('shared/run.rb.erb'),
      'console.rb' => artifact('shared/console.rb'),
      'config/database.yml' => artifact('shared/database.yml.erb'),
      'config/application.yml' => artifact('shared/application.yml.erb')
    }

    API_TEMPLATES = {
      'lib/server.rb' => artifact('api/server.rb.erb'),
      'Gemfile' => artifact('api/Gemfile.erb')
    }

    UI_TEMPLATES = {
      'lib/server.rb' => artifact('ui/server.rb.erb'),
      'Gemfile' => artifact('ui/Gemfile.erb')
    }

    options = Parsers::INIT.parse

    if options.app_name.nil? || options.app_name.empty? || ['-h', '--help'].any? { |flag| options.app_name == flag } || options.help?
      puts Parsers::INIT.help
      exit 0
    end

    options.output = File.join(options.output || Dir.pwd, options.app_name.method_case)
    options.class_name = options.app_name.to_s.class_case unless options.class_name

    options.db_path = File.join(options.output, "data/#{options.class_name.method_case}.db")
    options.dev_db_path = File.join(options.output, "data/#{options.class_name.method_case}_dev.db")

    gen_folders(options.output, API_FOLDERS)
    gen_folders(options.output, UI_FOLDERS) unless options.api?

    SHARED_TEMPLATES.each do |file, template|
      render_template(template, File.join(options.output, file), options)
    end

    if options.api?
      puts 'Generating base files for API...'
      API_TEMPLATES.each do |file, template|
        render_template(template, File.join(options.output, file), options)
      end
    else
      puts 'Generating base files for UI...'
      UI_TEMPLATES.each do |file, template|
        render_template(template, File.join(options.output, file), options)
      end
    end

  end
end
