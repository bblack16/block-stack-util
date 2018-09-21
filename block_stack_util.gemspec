
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "block_stack/util/version"

Gem::Specification.new do |spec|
  spec.name          = "block_stack_util"
  spec.version       = BlockStack::Util::VERSION
  spec.authors       = ["Brandon Black"]
  spec.email         = ["d2sm10@hotmail.com"]

  spec.summary       = %q{BlockStack Util provides the core functionality that is shared by all other BlockStack libraries.}
  spec.description   = %q{Core methods for all of the BlockStack gems.}
  spec.homepage      = "https://github.com/bblack16/block-stack-util"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ['block-stack']
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'bblib', '~> 2.0'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
