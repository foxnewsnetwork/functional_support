class Float

  def round_to_nearest(n=1)
    how_many_ns = (self / n)
    complete_ns = how_many_ns.to_i
    partial_ns = how_many_ns - complete_ns
    if partial_ns >= 0.5
      (complete_ns + 1) * n
    else
      complete_ns * n
    end
  end
end