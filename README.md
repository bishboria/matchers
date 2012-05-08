# Matchers

A toy project to think about using matchers more in tests. Rather than settling for operations on primitives like:

``` ruby
check_that(3 != 4))
check_that(some_array.length == 5)
```

It should be more like:

```ruby
check_that 3, is_not( equal_to 4 ))
check_that some_array, has_length(5)
```

## Bonus

```ruby
include ScottishMatchers
gonnae_see_if [1, 2], disnae( huv_lenth ( mare_than 2 ))
```

### Issues

* Doesn't show failures at all.
* Doesn't show nice failure messages when checks are invalid: message based on matchers used please.
