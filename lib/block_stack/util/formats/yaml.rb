module BlockStack
  module Formatters
    class YAML < Formatter

      self.mime_types   = ['text/yaml', 'application/yaml', 'application/x-yaml']
      self.content_type = :yaml
      self.format_keys  = [:yaml, :yml]

      def process(body, params = {})
        body.to_yaml
      end
    end
  end
end
