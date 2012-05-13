module Examples
  class Matcher
    def has method, value
      if value.is_a? Proc
        add_to_error "have #{method} "
        return -> x { value[x.send(method)] } 
      else
        add_to_error "have #{method} #{value}"
        return -> x { x.send(method) == value } 
      end
    end
  end
end
