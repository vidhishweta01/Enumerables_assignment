# Rubocop: disable Metrics/ModuleLength
# Rubocop: disable Metrics/MethodLength
# Rubocop: disable Lint/ShadowingOuterLocalVariable
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    c = 0
    statement = true
    if block_given?
      length.times do
        statement = false unless yield(self[c])
        c += 1
      end
    else
      while c < to_a.length
        yield (self[c])
        c += 1
      end
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    c = 0
    while c < to_a.length
      yield(to_a[c], c)
      c += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    c = 0
    if block_given?
      length.times do
        yield(self[c])
        c += 1
      end
    end
    self
  end

  def my_all?(pattern = nil)
    c = 0
    statement = true
    if block_given?
      length.times do
        statement = false unless yield(self[c])
        c += 1
      end
    elsif !pattern.nil?
      length.times do
        statement = false if self[i].scan(pattern)
      end
    end
    statement
  end

  def my_none?(pattern = nil)
    c = 0
    statement = false
    if block_given?
      length.times do
        statement = true unless yield(self[c])
        c += 1
      end
    elsif !pattern.nil?
      length.times do
        statement = true if self[i].scan(pattern)
      end
    end
    statement
  end

  def my_any?(pattern = nil)
    c = 0
    statement = false
    if block_given?
      length.times do
        statement = true if yield(self[c])
        c += 1
      end
    elsif !pattern.nil?
      length.times do
        statement = true if self[i].scan(pattern)
      end
    end
    statement
  end

  def my_count(var = nil)
    c = 0
    if !var.nil?
      length.times do |i|
        c += 1 if self[i] == var
      end
      c
    else
      length
    end
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || proc

    result = []
    if proc
      my_each { |x| result.push(proc.call(x)) }
    else
      my_each { |x| result.push(yield(x)) }
    end
    result
  end

  def my_inject(block = nil)
    my_array = self
    if !block.nil?
      my_array.my_inject { |sum, x| sum + x }
    elsif block_given?
      accumulator = my_array[0]
      my_array.my_each_with_index do |n, i|
        accumulator = yield(accumulator, n) if i != 0
      end
      accumulator
    end
  end
end


def multiply_els(array)
  print(array.my_inject { |sum| sum * 2 })
end
multiply_els([2, 3, 5])
# Rubocop: enable Metrics/ModuleLength
