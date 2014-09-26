class Proc
  def self.compose(f, g)
    lambda { |*args| f[g[*args]] }
  end
  def *(g)
    self.class.compose(self, g)
  end
end