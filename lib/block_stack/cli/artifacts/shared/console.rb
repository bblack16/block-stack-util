require_relative 'lib/server'

if (require 'pry' rescue false)
  pry.bind
else
  require 'irb'
  binding.irb
end
