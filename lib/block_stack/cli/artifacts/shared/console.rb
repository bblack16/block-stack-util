require_relative 'lib/server'

<%= @options.class_name %>.load_configs

if (require 'pry' rescue false)
  pry.bind
else
  require 'irb'
  binding.irb
end
