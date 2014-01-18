class Class

  def attr_hash_reader(*syms)
    options = syms.extract_options!
    hash_name = options[:store_in].to_s if options[:store_in].present?
    hash_name ||= "attributes"
    syms.each do |sym|
      raise NameError.new("invalid instance attribute name: #{sym}") unless sym =~ /^[_A-Za-z]\w*$/
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        def #{sym}
          (@#{hash_name} ||= {})[:#{sym}]
        end
      EOS
    end
  end

  def attr_hash_writer(*syms)
    options = syms.extract_options!
    hash_name = options[:store_in].to_s if options[:store_in].present?
    hash_name ||= "attributes"
    syms.each do |sym|
      raise NameError.new("invalid instance attribute name: #{sym}") unless sym =~ /^[_A-Za-z]\w*$/
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        def #{sym}=(obj)
          @#{hash_name} ||= {}
          @#{hash_name}[:#{sym}] = obj
        end
      EOS
    end
  end

  def attr_hash_accessor(*syms)
    attr_hash_writer *syms
    attr_hash_reader *syms
  end
end