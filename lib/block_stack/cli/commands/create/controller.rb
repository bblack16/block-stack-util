# DESCRIPTION: Build a generic template for a new controller

module BlockStack
  module CLI
    opts = Parsers::CREATE_CONTROLLER.parse

    if opts.help? || !opts.name
      puts Parsers::CREATE_CONTROLLER.help
      exit(0)
    end

    unless app_path
      BBLib.logger.warn("Could not locate a valid block_stack application. Be sure to run this command within the directory of your app.")
      exit(1)
    end

    opts.name = opts.name.class_case
    render_template(artifact('controller.rb.erb'), File.join(app_path, "app/controllers/#{opts.name.method_case}.rb"), opts)
  end
end
