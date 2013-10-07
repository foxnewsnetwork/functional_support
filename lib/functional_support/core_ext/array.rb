class Array

  def present_unshift(element=nil)
    unshift element if element.present?
    self
  end

  def uniq_merge(&block)
    lambda do |&merge_together|
      inject({}) do |hash, element|
        (hash[yield element] ||= []) << element
        hash
      end.to_a.map(&:last).inject(self.class.new) do |array, els|
        array.push els.reduce(&merge_together)
      end
    end
  end

  # Only apply map to things that successfully pass the filter, everything else is unchanged
  def filter_map(&filter_block)
    lambda do |&map_block|
      map do |element|
        if yield element
          map_block.call element 
        else
          element
        end
      end
    end
  end

end