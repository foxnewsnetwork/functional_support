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

end