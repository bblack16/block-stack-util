module BlockStack
  module Formatters
    class XML < Formatter
      attr_of Proc, :key_formatter, default: proc { |key| key.to_s.title_case.drop_symbols }

      self.mime_types   = ['text/xml', 'application/xml']
      self.content_type = :xml
      self.format_keys  = :xml

      def process(body, params = {})
        body = { data: clean_values(body) }
        '<?xml version="1.0" encoding="UTF-8"?>' + "\n" +
        Gyoku.xml(body, pretty_print: params[:pretty], key_converter: key_formatter)
      end

      def clean_values(payload)
        case payload
        when Array
          payload.map { |elem| clean_values(elem) }
        when Hash
          payload.hmap { |k, v| [clean_values(k).title_case.gsub('_', ''), clean_values(v)] }
        when String, Integer, Fixnum, Float, TrueClass, FalseClass
          payload
        else
          payload.to_s
        end
      end
    end
  end
end
