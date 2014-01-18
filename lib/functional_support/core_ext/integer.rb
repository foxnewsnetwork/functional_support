class Integer
  # map this number to a lowercased alphabet letter
  # 0-25 goes to a-z
  # 26-52 goes to aa-zz, etc.
  def to_alphabet
    qm = divmod 26
    return _convert_to_letter qm.last if qm.first.abs.zero?
    return qm.first.to_alphabet + _convert_to_letter(qm.last)
  end

  private

  def _convert_to_letter(v)
    raise Math::DomainError, "#{v} is outside the range of the English alphabet" if v > 25
    @@_the_alphabet_of_lowercase_letters ||= ('a'...'z').to_a.append('z')
    @@_the_alphabet_of_lowercase_letters[v.to_i.abs]
  end
end