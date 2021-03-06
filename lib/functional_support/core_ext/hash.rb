class Hash
  class EnforcedKeyMissing < StandardError; end
  class HashProc < Proc
    def to(key)
      call key
    end
  end
  # Like standard merge, except it ignores blank? values
  def initializing_merge(hash)
    self.clone.tap do |cloned_hash|
      hash.each do |key, value|
        cloned_hash[key] = hash[key] if hash[key].present?
      end
    end
  end

  def values_around(symbol)
    self[symbol] || self[symbol.to_s]
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

  def enforce!(*keys)
    keys.reduce(self.class.new) do |hash, key|
      raise EnforcedKeyMissing.new("#{key} is blank") if self[key].blank? 
      hash[key] = self[key]
      hash
    end
  end

  def permit(*keys)
    keys.reduce(self.class.new) do |hash, key|
      hash[key] = self[key] if self.has_key?(key)
      hash
    end
  end

  def key_map(&block)
    clone.key_map!(&block)
  end

  def key_map!(&block)
    tap do |hash|
      hash.keys.each do |key|
        hash[yield(key)] = hash.delete key if hash.has_key? key
      end
    end
  end

  def alter_key_from!(from_key)
    HashProc.new do |to_key|
      new_value = self.delete from_key
      self[to_key] = new_value if new_value.present?
      self
    end
  end

  def alter_key_from(from_key)
    self.clone.alter_key_from! from_key
  end

end