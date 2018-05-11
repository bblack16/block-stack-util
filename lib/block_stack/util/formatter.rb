module BlockStack
  # Base class for format converts. These are for turning ANYTHING into
  # a sensible representation in a specific format (like JSON, YAML, etc...)
  class Formatter
    include BBLib::Effortless
    include BBLib::Prototype

    # When passed as a param, the following is used to select this formatter
    # For example, a get route with either ".txt" or "?format=txt" would match below
    attr_ary_of [Symbol], :format_keys, default: [:text], singleton: true

    # Used for autodetection. If a request matches one of these mime types, this formatter is used.
    attr_ary_of [String, Array], :mime_types, default: 'text/html', singleton: true

    # What content type this formatter will return. Can be a string or the symbol equivalent that sinatra respects (e.g. :json)
    attr_of [String, Symbol], :content_type, default: :text, singleton: true

    bridge_method :mime_types, :content_type, :format_keys

    def self.formatters
      descendants
    end

    def self.formatter(type)
      formatters.find do |formatter|
        formatter.format_keys.include?(type.to_sym) || formatter.mime_types.include?(type.to_s)
      end || self
    end

    def self.format(type, content, opts = {})
      formatter(type).process(content, opts)
    end

    def format_match?(param)
      format_keys.any? { |f| f.to_s.downcase == param.to_s.downcase }
    end

    def mime_type_match?(accept)
      accept.any? { |a| mime_types.any? { |m| m == a } }
    end

    def process(body, params = {})
      body.to_s
    end

  end

  require_all(File.expand_path('../formats', __FILE__))
end
