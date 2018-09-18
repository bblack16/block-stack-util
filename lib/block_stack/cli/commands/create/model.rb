# DESCRIPTION: Build a generic template for a new model

module BlockStack
  module CLI
    opts = Parsers::CREATE_MODEL.parse

    if opts.help? || !opts.name
      puts Parsers::CREATE_MODEL.help
      exit(0)
    end

    unless app_path
      BBLib.logger.warn("Could not locate a valid block_stack application. Be sure to run this command within the directory of your app.")
      exit(1)
    end

    opts.name = opts.name.class_case

    opts.fields = opts.arguments.find_all do |arg|
      arg =~ /[\S]+\:[\S]+/
    end.hmap do |arg|
      arg.split(':', 2)
    end

    render_template(artifact('model.rb.erb'), File.join(app_path, "app/models/#{opts.name.method_case}.rb"), opts)
  end
end
