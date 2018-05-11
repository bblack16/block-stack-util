module BlockStack
  module Formatters
    class JSON < Formatter
      self.mime_types   = ['text/json', 'application/json']
      self.content_type = :json
      self.format_keys  = :json

      def process(body, params = {})
        body = { data: body } unless BBLib.is_any?(body, Array, Hash)
        params.include?(:pretty) ? ::JSON.pretty_generate(body) : body.to_json
      end
    end
  end
end
