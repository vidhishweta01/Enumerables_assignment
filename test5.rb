# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    c = 0
    while c < to_a.length
      yield(to_a[c])
      c += 1
    end
    self
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

    result = []
    my_each { |item| result << item if yield(item) }
    result
  end

  def my_all?(pattern = nil)
    c = 0
    statement = true
    if block_given?
      to_a.length.times do
        statement = false unless yield(to_a[c])
        c += 1
      end
    elsif !pattern.nil?
      if respond_to?(:to_ary)
        my_array = self
        to_a.length.times do
          begin
            if self[c].is_a?(pattern)
              statement = true
            else
              statement = false
              break
            end
          rescue StandardError
            statement = false if self[c].scan(match)
          end
          c += 1
        end
      else
        statement = false
      end
    end
    statement
  end

  def my_none?(pattern = nil)
    c = 0
    my_array = []
    statement = true
    if block_given?
      to_a.length.times do
        statement = false if yield(to_a[c])
        c += 1
      end
    elsif !pattern.nil?
      if respond_to?(:to_ary)
        my_array = self
        to_a.length.times do
          begin
            if !self[c].is_a?(pattern)
              statement = true
            else
              statement = false
              break
            end
          rescue StandardError
            statement = false if self[c].scan(pattern)
          end
          c += 1
        end
      else
        statement = false
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
      if respond_to?(:to_ary)
        my_array = self
        length.times do
          begin
            if self[c].is_a?(pattern)
              statement = true
              break
            end
          rescue StandardError
            statement = true if self[i].scan(pattern)
          end
          c += 1
        end
      else
        statement = false
      end
    end
    statement
  end

  def my_count(var = nil)
    c = 0
    if !var.nil?
      to_a.length.times do |i|
        c += 1 if to_a[i] == var
      end
      c
    else
      to_a.length
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

  def my_inject(*arg)
    arr = is_a?(Array) ? self : to_a
    result = arg[0] if arg[0].is_a? Integer

    if arg[0].is_a?(Symbol) || arg[0].is_a?(String)
      sym = arg[0]
    elsif arg[0].is_a?(Integer)
      sym = arg[1] if arg[1].is_a?(Symbol) || arg[1].is_a?(String)
    end

    if sym
      arr.my_each { |item| result = result ? result.send(sym, item) : item }
    else
      arr.my_each { |item| result = result ? yield(result, item) : item }
    end

    result
  end
end

def multiply_els(array)
  p array.my_inject(1) { |r, i| r * i }
end
rang = Range.new(5, 10)
multiply_els(rang)
puts
multiply_els([23, 34, 56])
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
