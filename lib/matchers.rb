module Matchers
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

  def check_that x, y
    y[x] == true
  end

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

  def add_to_error part
    initialize_error
    @error += part
  end

  def initialize_error
    @error ||= ""
  end
end
