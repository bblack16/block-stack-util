# DESCRIPTION: Build a generic template for a new model

module BlockStack
  module CLI
    opts = Parsers::CREATE_MODEL.parse

    if opts.help? || !opts.name
      puts Parsers::CREATE_MODEL.help
      exit(0)
    end

    app_path!

    if opts.name.include?('/')
      split = opts.name.split('/')
      opts.nested_path = split[0..-2].join('/')
      opts.path = 'app/models/' + opts.nested_path
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
    render_template(artifact('shared/model_seed.rb.erb'), File.join(app_path, "#{opts.nested_path}/scripts/seeds/#{opts.name.method_case}.rb"), opts)
  end
end
