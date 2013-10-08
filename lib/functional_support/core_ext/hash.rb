class Hash
  # Like standard merge, except it ignores blank? values
  def initializing_merge(hash)
    self.clone.tap do |cloned_hash|
      hash.each do |key, value|
        cloned_hash[key] = hash[key] if hash[key].present?
      end
    end
  end

  # accesses a key, and maps over that key unless blank
  def access_map(key, &block)
    clone.access_map! key, &block
  end

  def access_map!(*keys, &block)
    tap do |hash|
      keys.each do |key|
        if hash[key].present?
          hash[key] = yield if 0 == block.arity
          hash[key] = yield hash[key] if 1 == block.arity
          hash[key] = yield key, hash[key] if 2 == block.arity
        end
      end
    end
  end

  def permit(*keys)
    keys.reduce(self.class.new) do |hash, key|
      hash[key] = self[key] if self[key].present?
      hash
    end
  end

end