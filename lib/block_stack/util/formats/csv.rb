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
        p rows
        ::CSV.generate(col_sep: delimiter) do |csv|
          csv << rows.first.keys
          rows.each { |row| csv << row.values }
        end
        # columns = [:data]
        # content = [data]
        # case data
        # when Array
        #   if data.all? { |d| d.is_a?(Hash) }
        #     columns = data.map(&:keys).uniq
        #     content = data.map do |line|
        #       columns.map { |h| line[h] }
        #     end
        #   end
        # when Hash
        #   # TODO Support hash with arrays as values (somehow?)
        #   columns = data.keys
        #   content = data.values
        # end
        # content = [content] unless content.is_a?(Array) && content.all? { |c| c.is_a?(Array) }
        # header = columns.map { |col| "\"#{col.to_s.gsub('"', '\\"')}\"" }.join(delimiter) + "\n"
        # rows = content.map do |row|
        #   row.map { |value| "\"#{value.to_s.gsub('"', '\\"')}\"" }.join(delimiter)
        # end.join("\n")
        # header + rows
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
