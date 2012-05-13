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
