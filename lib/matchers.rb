module ErrorMessages
  def check_that x, y
    add_to_error "error: expected #{x} to "
    record_result y[x]
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

module Matchers
  include ErrorMessages

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
    unless y.is_a? Proc
      add_to_error "have length #{y}"
      return -> x { x.length == y } 
    end
    add_to_error "have length "
    -> x { y[x.length] }
  end
  alias_method :have_length, :has_length

  def has_count y
    add_to_error "have count #{y}"
    return -> x { x.count == y } unless y.is_a? Proc
    -> x { y[x.count] }
  end
  alias_method :have_count, :has_count
end
