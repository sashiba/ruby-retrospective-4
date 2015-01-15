class NumberSet
  include Enumerable
  def each (&block)
   # @numbers.each { |n| yield n }
   @numbers.each(&block)
  end

  def initialize
    @numbers = []
  end

  def <<(other)
    @numbers.push(other) unless @numbers.include?(other)
  end

  def size
    @numbers.size
  end

  def empty?
    @numbers.size == 0
  end

  def [](filter)
    filtered = NumberSet.new
    filtered = @numbers.select { |number| filter.filtering number }
  end
end

module FOperations
 def filtering(number)
    @filter.call (number)
  end
def &(other_filter)
  Filter.new { |number| filtering(number) and other_filter.filtering (number) }
end

def |(other_filter)
  Filter.new { |number| filtering(number) or other_filter.filtering (number) }
end
end

class Filter
  include FOperations
   def initialize(&block)
    @filter = block
  end
end

class SignFilter
  include FOperations
  def initialize(key)
    case key
    when :positive     then @filter = Proc.new { |number| number > 0 }
    when :non_positive then @filter = Proc.new { |number| number <= 0 }
    when :negative     then @filter = Proc.new { |number| number < 0 }
    when :non_negative then @filter = Proc.new { |number| number >= 0 }
    end
  end
end

class TypeFilter
 include FOperations
  def initialize(key)
    case key
    when :integer then @filter = Proc.new { |number| number.is_a? Integer }
    when :complex then @filter = Proc.new { |number| number.is_a? Complex }
    when :real    then @filter = Proc.new do |number|
      (number.is_a? Rational) or (number.is_a? Float)
       end
    end
  end
end