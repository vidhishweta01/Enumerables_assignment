# rubocop: disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Style/Documentation

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
      length.times do |c|
        yield (self[c])
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
    return to_enum(:my_each_with_index) unless block_given?
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

  def my_count(x = nil)
    c = 0
    if !x.nil?
      length.times do |i|
        c += 1 if self[i] == x
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

  def my_inject(*args)
    if args.length == 1 && !block_given?
      return my_inject { |n, i| n.send(args.first, i) }
    end
    if args.length == 2 && !block_given?
      my_aggregator = args.first
      each do |i|
        my_aggregator = my_aggregator.send(args[1], i)
      end
      return my_aggregator
      return my_inject { |n, i| n.send(args.first, i) }
    end
    if args.length == 1
      my_aggregator = args.first
      each do |i|
        my_aggregator = yield(my_aggregator, i)
      end
      return my_aggregator
    end
    my_aggregator = first
    each do |i|
      next if i == first
      my_aggregator = yield(my_aggregator, i)
    end
    my_aggregator
  end
end

def multiply_els(array)
  print(array.my_inject { |sum, n| sum * n })
end
multiply_els([2, 3, 5])
