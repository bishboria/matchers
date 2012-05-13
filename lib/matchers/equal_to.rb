module Examples
  class Matcher
    def equal_to y
      add_to_error "equal #{y}"
      -> x { x == y }
    end
    alias_method :equals, :equal_to
  end
end
