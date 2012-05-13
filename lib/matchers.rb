module ErrorMessages
  def check_that x, y
    record_result y[x]
    add_to_error "error: expected #{x} to "
    reset_error
  end

  def add_to_error part
    initialize_error
    @error = part.to_s + @error
  end

  def initialize_error
    @error ||= ""
  end

  def record_result result
    @correct = result
  end

  def reset_error
    @old_error, @error = @error, ""
    @old_error unless correct?
  end

  def correct?
    @correct
  end
end

module Examples
  class Matchers
    include ErrorMessages

    def initialize block
      @block = block
    end

    def evaluate!
      instance_eval &@block
    end

    def equal_to y
      add_to_error "equal #{y}"
      -> x { x == y }
    end
    alias_method :equals, :equal_to

    def greater_than y
      add_to_error "be greater than #{y}"
      -> x { x > y }
    end

    def less_than y
      add_to_error "be less than #{y}"
      -> x { x < y }
    end

    def is_not y
      add_to_error "not "
      -> x { !(y[x]) }
    end
    alias_method :does_not, :is_not

    def has_length y
      has :length, y
    end
    alias_method :have_length, :has_length

    def has_count y
      has :count, y
    end
    alias_method :have_count, :has_count

    def contains y
      add_to_error "contain #{y}"
      -> x { x.include? y }
    end

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

  def examples &block
    Matchers.new(block).evaluate!
  end
end
