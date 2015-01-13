class NumberSet
  attr_accessor :nums
  include Enumerable

  def each &block
          numbers.each { |n| yield n }
  end

  def initialize
          numbers = Array.new
  end

  def <<(other)
        if not numbers.include?(other) then
          numbers.push(other)
    end
  end

  def size
    counter = 0
          numbers.each { |each| counter += 1 }
          return counter
  end

  def empty?
    numbers.size == 0
  end

  def [](class_name)
    case class_name
    when class_name == Filter     then self.Filter.initialize
    when class_name == TypeFilter then self.SingFilter.initialize
    when class_name == SingFilter then self.SingFilter.initialize
    end
  end

  def |(other)
    numbers.each do |number|
     numbers << other if not numbers == other
   end
  end
end

class Filter < NumberSet
  filtered = NumberSet.new
 def initialize(&block)
     numbers.each do |number|
      filtered << number if yield number
    end
  end
end
class SingFilter < NumberSet
  attr_accessor :filtered
   filtered = NumberSet.new
  def initialize(key)
    case key
    when key == :positive     then numbers.select { |n| n > 0 }
    when key == :non_positive then numbers.select { |n| n <= 0 }
    when key == :negative     then numbers.select { |n| n < 0 }
    when key == :non_negative then numbers.select { |n| n >= 0 }
    end
    filtered = numbers
  end
end

class TypeFilter < NumberSet
  attr_accessor :filtered
  filtered = NumberSet.new
  def initialize(key)
    case key
    when key == :integer then numbers.select { |n| n.is_a? Integer }
    when key == :complex then numbers.select { |n| n.is_a? Complex }
    when key == :real    then
        numbers.select { |n| n.is_a? Float or n.is_a? Rational }
    end
    filtered = numbers
  end
end