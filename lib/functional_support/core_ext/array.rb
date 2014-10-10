class Array
  class ProductWithEmptyArray < StandardError
  end
  # Returns the Cartesian product of two arrays
  def product(xs)
    raise(ProductWithEmptyArray, "can't product #{self} with #{xs}") if count == 0 || xs.count == 0
    return xs.map { |x| [first, x] } if count == 1
    thing = xs.map { |x| [first, x] }
    thing + tail.product(xs)
  end

  def tail
    self[1..-1]
  end

  def head
    self.take self.count - 1 unless self.count == 0
  end

  # same as reduce, except the reduction function can have arity > 2
  # with the second, third, etc. arguments being the lookahead
  def reduce_with_lookahead(*parameters, &reducer)
    case parameters.length
    when 0
      in_repeated_groups_of(reducer.arity - 1).reduce do |acc, arr|
        reducer.call acc, *arr
      end
    when 1
      init = parameters.first
      in_repeated_groups_of(reducer.arity - 1).reduce(init) do |acc, arr|
        reducer.call acc, *arr
      end
    else
      raise LocalJumpError, "no block given"
    end
  end
  alias_method :inject_with_lookahead, :reduce_with_lookahead

  # Suppose n = 3, this takes something like [1,2,3,4,5] 
  # and splits it into something like the following:
  # [[1,2,3], [2,3,4], [3,4,5]]
  def in_repeated_groups_of(n=1)
    return [self] if length == n
    return shift(nil).in_repeated_groups_of(n) if length < n
    [take(n)] + tail.in_repeated_groups_of(n)
  end

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