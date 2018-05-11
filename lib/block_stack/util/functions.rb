module BlockStack
  # Convenience for loading all ruby files recursively in a directory
  def self.require_all(path, recursive: true)
    BBLib.scan_files(path, '*.rb', recursive: recursive) do |file|
      require_relative file
    end
  end

  # Removes one set of parenthesis from the outside of a string if it is enclosed
  # in a pair of them.
  # Used by BlockStack::Query
  def self.safe_uncapsulate(str)
    str = str.strip
    while str.start_with?('(') && str.end_with?(')')
      str = str[1..-2]
    end
    str
  end

  # Takes anything and converts it into an array of hashes.
  # Useful for generating formatted content such as CSVs or tables
  def self.to_hash_rows(objects, headers = nil)
    headers = _generate_headers(objects)
    [objects].flatten(1).map do |object|
      _to_hash_row(object, headers)
    end
  end

  protected

  # Helper method for to_hash_rows
  def self._to_hash_row(object, headers)
    case object
    when Hash
      headers.hmap do |key|
        [key, object[key]]
      end
    else
      headers.hmap do |method|
        [
          method,
          object.respond_to?(method) && object.method(method).arity == 0 ? object.send(method) : nil
        ]
      end
    end
  end

  # Helper method for to_hash_rows
  def self._generate_headers(objects)
    [].tap do |headers|
      [objects].flatten(1).each do |object|
        case object
        when Hash
          object.keys.each do |key|
            headers << key unless headers.include?(key)
          end
        when BBLib::Effortless
          object._attrs.each do |name, opts|
            next if opts[:singleton]
            headers << name unless headers.include?(name)
          end
        end
      end
    end
  end
end
