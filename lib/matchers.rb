module ErrorMessages
  def check_that x, y
    add_to_error "#{x} is not "
    record_result y[x]
    reset_error
  end

  def initialize_error
    @error ||= ""
  end

  def add_to_error part
    initialize_error
    @error = part.to_s + @error
  end

  def reset_error
    @old_error, @error = @error, ""
    @old_error unless correct?
  end

  def record_result result
    @correct = result
  end

  def correct?
    @correct
  end
end

module Matchers
  include ErrorMessages

  def equal_to y
    add_to_error "equal to #{y}"
    -> x { x == y }
  end
  alias_method :equals, :equal_to

  def greater_than y
    -> x { x > y }
  end

  def less_than y
    -> x { x < y }
  end

  def is_not y
    -> x { !(y[x]) }
  end
  alias_method :does_not, :is_not

  def has_length y
    return -> x { x.length == y } unless y.is_a? Proc
    -> x { y[x.length] }
  end
  alias_method :have_length, :has_length

  def has_count y
    return -> x { x.count == y } unless y.is_a? Proc
    -> x { y[x.count] }
  end
  alias_method :have_count, :has_count
end
