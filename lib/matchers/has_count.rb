module Examples
  class Matcher
    def has_count y
      has :count, y
    end
    alias_method :have_count, :has_count
  end
end
