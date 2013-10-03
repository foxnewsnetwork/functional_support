class Hash
  # Like standard merge, except it ignores blank? values
  def initializing_merge(hash)
    self.class.new.tap do |new_hash|
      each do |key, value|
        new_hash[key] = hash[key].blank? ? value : hash[key]
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