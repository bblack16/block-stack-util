module BlockStack
  module Formatters
    class HTML < Formatter
      self.mime_types   = 'text/html'
      self.format_keys  = :html
      self.content_type = :html
    end
  end
end
