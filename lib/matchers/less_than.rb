module Examples
  class Matcher
    def less_than y
      add_to_error "be less than #{y}"
      -> x { x < y }
    end
  end
end
