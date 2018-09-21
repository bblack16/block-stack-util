# DESCRIPTION: Build a generic template for a new controller

module BlockStack
  module CLI
    opts = Parsers::CREATE_CONTROLLER.parse

    if opts.help? || !opts.name
      puts Parsers::CREATE_CONTROLLER.help
      exit(0)
    end

    app_path!

    opts.name = opts.name.class_case
    render_template(artifact('controller.rb.erb'), File.join(app_path, "app/controllers/#{opts.name.method_case}.rb"), opts)
  end
end
