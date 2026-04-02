module Checkable
  def valid_integer? str
    Integer(str)
    true
  rescue ArgumentError, TypeError
    false
  end
end
