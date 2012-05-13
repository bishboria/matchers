module Examples
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
  end
end
