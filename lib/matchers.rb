Dir.glob(File.dirname(__FILE__) + "/matchers/*") {|file| require file}

module Examples
  class Matcher
    include Recorder

    def initialize reporter, block
      reset_all_errors
      @reporter = reporter
      @block = block
    end

    def evaluate!
      start = Time.now
      instance_eval &@block
      stop = Time.now
      puts @reporter.new(@all_errors, @example_count, start, stop).report
    end
  end

  def examples &block
    Matcher.new(Reporter, block).evaluate!
  end
end

module Examples
  class Matcher
    def is_not y
      add_to_error "not "
      -> x { !(y[x]) }
    end
    alias_method :does_not, :is_not
  end
end

module Examples
  class Matcher

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
