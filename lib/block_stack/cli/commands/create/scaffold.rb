# DESCRIPTION: Create a controller and views for a new model.

module BlockStack
  module CLI
    opts = Parsers::CREATE_SCAFFOLD.parse

    if opts.help? || !opts.name
      puts Parsers::CREATE_SCAFFOLD.help
      exit(0)
    end

    app_path!

    opts.name = opts.name.class_case

    opts.fields = opts.arguments.find_all do |arg|
      arg =~ /[\S]+\:[\S]+/
    end.hmap do |arg|
      arg.split(':', 2)
    end

    render_template(artifact('controller.rb.erb'), File.join(app_path, "app/controllers/#{opts.name.method_case}.rb"), opts)
    render_template(artifact('model.rb.erb'), File.join(app_path, "app/models/#{opts.name.method_case}.rb"), opts)
  end
end
