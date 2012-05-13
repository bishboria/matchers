require_relative "../lib/matchers"
include Examples

examples do
  check_that 5, equal_to(5) # true
  check_that 5, is_not( equal_to 5 ) # false
  check_that 5, is_not( equal_to 4 ) # true
  check_that 1, greater_than(2) # false
  check_that 1, is_not( greater_than 2 ) # true
  check_that [1, 2], does_not( have_length 3 ) # true
  check_that [1, 2], has_length( greater_than 1 ) # true
  check_that [1, 2], does_not( have_length( greater_than 2 )) # true
end

# Introducing errors

examples do
  check_that 1, equals(2)
  check_that( check_that(1, is_not( equal_to 1 )),
              equals( "error: expected 1 to not equal 1" ))

  check_that( check_that(1, equals(2)),
              equals( "error: expected 1 to equal 2" ))

  check_that( check_that(1, greater_than(2)),
              equals( "error: expected 1 to be greater than 2" ))

  check_that( check_that(2, less_than(1)),
              equals( "error: expected 2 to be less than 1" ))

  check_that( check_that([1,2], has_length(3)),
              equals( "error: expected [1, 2] to have length 3" ))

  check_that( check_that([1,2], has_count(3)),
              equals( "error: expected [1, 2] to have count 3" ))

  check_that( check_that([1,2], has_length( less_than 2 )),
              equals( "error: expected [1, 2] to have length be less than 2" ))

  check_that( check_that([1,2], has_count( less_than 2 )),
              equals( "error: expected [1, 2] to have count be less than 2" ))

  check_that("hello world", contains( "hello" ))
end
