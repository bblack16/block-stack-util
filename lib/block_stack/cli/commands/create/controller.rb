# DESCRIPTION: Build a generic template for a new controller

module BlockStack
  module CLI
    opts = Parsers::CREATE_CONTROLLER.parse

    if opts.help? || !opts.name
      puts Parsers::CREATE_CONTROLLER.help
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
    render_template(artifact('controller.rb.erb'), File.join(app_path, "#{opts.path}/#{opts.name.method_case}.rb"), opts)
  end
end
