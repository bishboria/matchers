require_relative "../lib/matchers"
include Matchers

check_that 5, equal_to(5) # true
check_that 5, is_not( equal_to 5 ) # false
check_that 5, is_not( equal_to 4 ) # true
check_that 1, greater_than(2) # false
check_that 1, is_not( greater_than 2 ) # true
check_that [1, 2], does_not( have_length 3 ) # true
check_that [1, 2], has_length( greater_than 1 ) # true
check_that [1, 2], does_not( have_length( greater_than 2 )) # true

# Introducing errors

check_that 1, equals(2)
puts check_that( check_that(1, is_not( equal_to 1 )),
                 equals( "error: expected 1 to not equal 1" ))

puts check_that( check_that(1, equals(2)),
                 equals("error: expected 1 to equal 2"))

puts check_that( check_that(1, greater_than(2)),
                 equals("error: expected 1 to be greater than 2"))
