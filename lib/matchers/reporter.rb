module Examples
  class Reporter
    def initialize all_errors, total_examples, start, stop
      @all_errors = all_errors
      @total_examples = total_examples
      @start = start
      @stop = stop
    end

    def report
"""
#{@all_errors.join "\n"}
#{@total_examples} examples run in #{@stop - @start} seconds
"""
    end
  end
end

