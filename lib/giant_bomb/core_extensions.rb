class Array
  alias_method :blank?, :empty?

  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end

end

class Hash #:nodoc:
  alias_method :blank?, :empty?
end

class Float
  def self.parse(val)
    Float(val)
  end
end

class Integer
  def self.parse(val)
    Integer(val)
  end
end

class Numeric
  def blank?
    false
  end
end

class Object
  # An object is blank if it's false, empty, or a whitespace string.
  # For example, "", "   ", +nil+, [], and {} are blank.
  #
  # This simplifies:
  #
  #   if !address.nil? && !address.empty?
  #
  # ...to:
  #
  #   if !address.blank?
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  def try(method)
    send method if respond_to? method
  end

end


class NilClass
  def blank?
    true
  end
end

class FalseClass
  def blank?
    true
  end
end

class TrueClass
  def blank?
    false
  end
end

class String
  def blank?
    self !~ /\S/
  end
end

