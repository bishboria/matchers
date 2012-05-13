module Examples
  class Matcher
    def contains y
      add_to_error "contain #{y}"
      -> x { x.include? y }
    end
  end
end
