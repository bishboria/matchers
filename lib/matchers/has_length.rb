module Examples
  class Matcher
    def has_length y
      has :length, y
    end
    alias_method :have_length, :has_length
  end
end
