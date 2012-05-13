module RecordErrors
  def check_that x, y
    record_result y[x]
    record_error x
  end

  def add_to_error part
    initialize_error
    @error = part.to_s + @error
  end

  private

  def record_error x
    add_to_error "error: expected #{x} to "
    add_new_error
    reset_error
  end

  def initialize_error
    @error ||= ""
  end

  def record_result result
    @example_count ||= 0
    @example_count += 1
    @correct = result
  end

  def reset_error
    @old_error, @error = @error, ""
    @old_error unless correct?
  end

  def correct?
    @correct
  end

  def reset_all_errors
    @all_errors = []
  end

  def add_new_error
    @all_errors << @error unless correct?
  end

  def result start, stop
"""
#{@all_errors.join "\n"}
#{@example_count} examples run in #{stop - start} seconds
"""
  end
end

module Examples
  class Matcher
    include RecordErrors

    def initialize block
      reset_all_errors
      @block = block
    end

    def evaluate!
      start = Time.now
      instance_eval &@block
      stop = Time.now
      puts result(start, stop)
    end
  end

  def examples &block
    Matcher.new(block).evaluate!
  end
end

module Examples
  class Matcher
    def equal_to y
      add_to_error "equal #{y}"
      -> x { x == y }
    end
    alias_method :equals, :equal_to
  end
end

module Examples
  class Matcher
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
end
