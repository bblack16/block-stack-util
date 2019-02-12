# DESCRIPTION: Create a controller and views for a new model.

module BlockStack
  module CLI
    opts = Parsers::CREATE_SCAFFOLD.parse

    if opts.help? || !opts.name
      puts Parsers::CREATE_SCAFFOLD.help
      exit(0)
    end

    app_path!

    if opts.name.include?('/')
      split = opts.name.split('/')
      opts.path = 'app/models/' + split[0..-2].join('/')
      opts.name = split.last
    else
      opts.path = 'app/models'
    end

    opts.name = opts.name.class_case

    opts.fields = opts.arguments.find_all do |arg|
      arg =~ /[\S]+\:[\S]+/
    end.hmap do |arg|
      arg.split(':', 2)
    end

    render_template(artifact('model.rb.erb'), File.join(app_path, "#{opts.path}/#{opts.name.method_case}.rb"), opts)

    # Change class name for controller
    opts.name = "#{opts.name}Controller"
    render_template(artifact('controller.rb.erb'), File.join(app_path, "app/controllers/#{opts.name.method_case}.rb"), opts)
  end
end
