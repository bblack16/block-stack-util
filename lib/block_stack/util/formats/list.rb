module BlockStack
  module Formatters
    class List < Formatter
      self.mime_types   = ['text/list']
      self.content_type = :list
      self.format_keys  = :list

      def process(body, params = {})
        processed = body.hmap do |k, v|
          [
            k.to_s.gsub(/[-_.]/, ' ').title_case,
            process_value(v)
          ]
        end
        processed = processed.sort_by { |k, v| k }.to_h if params[:sort]
        spacing = processed.map { |k, v| k.to_s.size }.max + (params[:extra_padding] || 3)
        processed.map do |field, value|
          key = params[:right_justify] ? "#{field}: ".rjust(spacing) : "#{field}:".ljust(spacing)
          key + value
        end.join("\n")
      end

      def process_value(value, params = {})
        fallback = params[:fallback] || :json
        case (value)
        when Hash, Array
          Formatter.process(fallback, value)
        else
          value.to_s
        end
      end
    end
  end
end
