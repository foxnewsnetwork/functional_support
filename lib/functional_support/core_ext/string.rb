class String
  
  # Appends crap to the string until the given string satisfies the given condition
  def append_until(content=" ", &condition)
    return self if yield self
    (self + content).append_until(content, &condition)
  end

  def prepend_until(content=" ", &condition)
    return self if yield self
    (content + self).prepend_until(content, &condition)
  end

  def consume(diet="")
    return self if diet.blank? or self.blank?
    if self[0] == diet[0]
      self[1..-1].consume diet[1..-1]
    else
      throw "Mismatched diet error #{diet}"
    end
  end
end