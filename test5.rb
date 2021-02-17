# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
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

  def my_all?(pat = nil)
    c = 0
    my_arr = []
    statement = true
    if block_given?
      to_a.length.times do
        statement = false unless yield(to_a[c])
        c += 1
      end
    elsif !pat.nil?
      my_arr = if respond_to?(:to_ary)
                 self
               else
                 to_a
               end
      case pat
      when Numeric
        statement = false unless my_arr.my_count(pat) == size
      when Regexp
        length.times do
          statement = false unless my_arr[c].match(pat)
          c += 1
        end
      when String
        statement = false if respond_to?(:to_s) && !my_arr.eql?(pat)
      when Array
        statement = false unless my_arr.my_count(pat) == size
      when TrueClass
        statement = false unless my_arr.my_count(pat) == size
      when FalseClass
        statement = false unless my_arr.my_count(pat) == size
      else
        my_arr.length.times do
          if my_arr[c].is_a?(pat)
            statement = true
          else
            statement = false
            break
          end
          c += 1
        end
      end
    elsif to_a.include? false
      statement = false
    end
    statement
  end

  def my_none?(pat = nil)
    c = 0
    my_arr = []
    statement = true
    if block_given?
      to_a.length.times do
        if yield(to_a[c])
          statement = false
          break
        else
          statement = true
        end
        c += 1
      end
    elsif !pat.nil?
      my_arr = if respond_to?(:to_ary)
                 self
               else
                 to_a
               end
      case pat
      when Numeric
        statement = false if my_arr.my_count(pat) == size
      when Regexp
        length.times do
          statement = false if my_arr[c].match(pat)
          c += 1
        end
      when String
        statement = false if respond_to?(:to_s) && my_arr.include?(pat)
      when Array
        statement = false unless my_arr.my_count(pat) == size
      when TrueClass
        statement = false unless my_arr.my_count(pat) == size
      when FalseClass
        statement = false unless my_arr.my_count(pat) == size
      else
        my_arr.length.times do
          if my_arr[c].is_a?(pat)
            statement = false
          else
            statement = true
            break
          end
          c += 1
        end
      end
    else
      c = 0
      while c < to_a.length
        if to_a[c]
          statement = false
          break
        else
          statement = true
        end
        c += 1
      end
    end
    statement
  end

  def my_any?(pat = nil)
    c = 0
    my_arr = []
    statement = true
    if block_given?
      to_a.length.times do
        if !yield(to_a[c])
          statement = false
        else
          statement = true
          break
        end
        c += 1
      end
    elsif !pat.nil?
      my_arr = if respond_to?(:to_ary)
                 self
               else
                 to_a
               end
      case pat
      when Numeric
        statement = false unless my_arr.include? pat
      when Regexp
        my_arr.length.times do
          statement = false unless my_arr[c].match(pat)
          c += 1
        end
      when String
        statement = false if respond_to?(:to_s) && !(my_arr.include? pat)
      when Array
        statement = false unless my_arr.include? pat
      when TrueClass
        statement = false unless my_arr.include? pat
      when FalseClass
        statement = false unless my_arr.include? pat
      else
        my_arr.length.times do
          if !my_arr[c].is_a?(pat)
            statement = false
          else
            statement = true
            break
          end
          c += 1
        end
      end
    end
    statement
  end

  def my_count(var = nil)
    c = 0
    if block_given?
      my_each { |i| c += 1 if yield(i) }
    elsif !var.nil?
      if to_a.include? var
        to_a.length.times do |i|
          c += 1 if to_a[i] == var
        end
      end
      c
    else
      c = size
    end
    c
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
    case arg[0]
    when Symbol, String
      sym = arg[0]
    when Integer
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
  false_array = [1, false, 'hi', []]
  true_array = [1, true, 'hi', []]
  p false_array.my_none? == false_array.none?
  p true_array.my_none? == true_array.none?
  p (1..3).none?(&proc { |num| num.even? }) == (1..3).my_none?(&proc { |num| num.even? })
  words = %w[programmer computer house car]
  p words.none?('car') == words.my_none?('car')
end
rang = Range.new(5, 10)
multiply_els(rang)

# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
