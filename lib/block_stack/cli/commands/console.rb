# DESCRIPTION: Runs a pry or irb console for the current BlockStack server

module BlockStack
  module CLI
    app_path!

    load_app_context

    if (require 'pry' rescue false)
      pry
    else
      require 'irb'
      binding.irb
    end
  end
end
