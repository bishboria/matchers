module Examples
  class Matcher
    def greater_than y
      add_to_error "be greater than #{y}"
      -> x { x > y }
    end
  end
end
