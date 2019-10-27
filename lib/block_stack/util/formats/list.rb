module BlockStack
  module Formatters
    class List < Formatter
      self.mime_types   = ['text/list']
      self.content_type = :list
      self.format_keys  = :list

      def process(body, params = {})
        spacing = body.max { |k, v| k.to_s.size } + 2
        body.map do |field, value|
          "#{field}:".ljust(spacing) + process_value(value, params)
        end
      end

      def process_value(value, params = {})
        fallback = params.fallback || :json
        case (value)
        when Map, ArrayList
          Formatter.process(fallback, value)
        else
          value.to_s
        end
      end
    end
  end
end
