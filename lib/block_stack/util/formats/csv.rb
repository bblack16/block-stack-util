module BlockStack
  module Formatters
    # TODO Use the Ruby csv library to generate csv instead
    class CSV < Formatter

      self.mime_types   = 'text/csv'
      self.format_keys  = :csv
      self.content_type = :csv

      def delimiter
        ','
      end

      def process(body, params = {})
        build_csv(body, params[:headers])
      end

      def build_csv(data, headers = nil)
        require 'csv'
        headers = headers.split(',') if headers.is_a?(String)
        rows = BlockStack.to_hash_rows(data, headers)
        ::CSV.generate(col_sep: delimiter) do |csv|
          csv << rows.first.keys
          rows.each { |row| csv << row.values }
        end
      end
    end

    class TSV < CSV

      self.mime_types   = 'text/tsv'
      self.format_keys  = :tsv
      self.content_type = :tsv

      def delimiter
        "\t"
      end

    end
  end
end
