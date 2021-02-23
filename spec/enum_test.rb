require_relative '../test5'
include Enumerable # rubocop:disable Style/MixinUsage

array = [6, 19, 19, 25, 7, 30, 20, 27, 22, 19, 18, 29, 12, 31, 2, 12, 0, 32, 1, 20]
words = %w[programmer computer house car]
false_array = [1, false, 'hi', []]
true_array = [1, true, 'hi', []]
arr = ['ruby']
block = proc { |num| num < 2 }
false_block = proc { |num| num > 9 }
true_block = proc { |num| num <= 9 }
false_any_array = [nil, false, nil, false]
true_any_array = [nil, false, true, []]
describe '#my_each' do
  it 'returns each element in array' do
    expect(array.my_each { |x| x + 1 }).to eql(array)
  end
end

describe '#my_each_with_index' do
  it 'return enum if no block' do
    expect(array.my_each_with_index).to be_a(Enumerator)
  end
  it 'return array if block' do
    expect(
      array.my_each_with_index do |x, i|
      end
    ).to eql(array)
  end
  it 'when empty enum no return nil' do
    expect([].my_each_with_index).not_to eql(nil)
  end
  it 'should return the sum of all indexes of the array ' do
    total = 0
    array.my_each_with_index do |_x, i|
      total += i
    end
    expect(total).to eql(190)
  end
end

describe '#my_select' do
  it 'Returns just the even numbers' do
    expect(array.my_select(&:even?)).to eql([6, 30, 20, 22, 18, 12, 2, 12, 0, 32, 20])
  end
end

describe '#my_count' do
  it 'return the number of values which are the same as the yield' do
    expect([2, 6, 7].my_count(&:even?)).to eql([2, 6, 7].count(&:even?))
  end
  it 'return the total number of values in an array' do
    expect([2, 6, 7].my_count).to eql([2, 6, 7].count)
  end

  it 'returns the number of values that are the same as the arg' do
    expect([2, 6, 7].count(2)).to eql([2, 6, 7].count(2))
  end
end

describe '#my_none?' do
  it 'returns true if all of the value are not of same datatype else false' do
    expect(array.my_none?(Float)).to eql(true)
    expect(array.my_none?(Integer)).to eql(false)
  end
  it 'behaves same as none?' do
    expect(words.my_none?('to')).to eql(words.none?('to'))
    expect(false_array.my_none?).to eql(false_array.none?)
    expect(true_array.my_none?).to eql(true_array.none?)
    expect(arr.my_none?(/r/)).to eql(arr.none?(/r/))
    expect((1..3).my_none?(&proc { |num| num.even? })).to eql((1..3).none?(&proc { |num| num.even? }))
    expect(array.my_none?(&false_block)).to eql(array.none?(&false_block))
    expect(array.my_none?(&true_block)).to eql(array.none?(&true_block))
    expect(array.my_none?(&block)).to eql(array.none?(&block))
    expect(true_any_array.my_none?(true)).to eql(true_any_array.none?(true))
    expect(false_any_array.my_none?).to eql(false_any_array.none?)
  end
end

describe '#my_all?' do
  it 'returns false if all of the value are not of same datatype else true' do
    expect(array.my_all?(Float)).to eql(false)
    expect(array.my_all?(Integer)).to eql(true)
  end
  it 'behaves same as all?' do
    expect(words.my_all?('to')).to eql(words.all?('to'))
    expect(false_array.my_all?).to eql(false_array.all?)
    expect(true_array.my_all?).to eql(true_array.all?)
    expect(arr.my_all?(/r/)).to eql(arr.all?(/r/))
    expect((1..3).my_all?(&proc { |num| num.even? })).to eql((1..3).all?(&proc { |num| num.even? }))
    expect(array.my_all?(&false_block)).to eql(array.all?(&false_block))
    expect(array.my_all?(&true_block)).to eql(array.all?(&true_block))
    expect(array.my_all?(&block)).to eql(array.all?(&block))
    expect(true_any_array.my_all?(true)).to eql(true_any_array.all?(true))
    expect(false_any_array.my_all?).to eql(false_any_array.all?)
  end
end

describe '#my_any?' do
  it 'returns true if any of the value are same datatype as given else false' do
    expect(array.my_any?(Float)).to eql(false)
    expect(array.my_any?(Integer)).to eql(true)
    expect([1, 'x', 3].my_any?(String)).to eql(true)
  end
  it 'behaves same as any?' do
    expect(words.my_any?('to')).to eql(words.any?('to'))
    expect(false_array.my_any?).to eql(false_array.any?)
    expect(true_array.my_any?).to eql(true_array.any?)
    expect(arr.my_any?(/r/)).to eql(arr.any?(/r/))
    expect((1..3).my_any?(&proc { |num| num.even? })).to eql((1..3).any?(&proc { |num| num.even? }))
    expect(array.my_any?(&false_block)).to eql(array.any?(&false_block))
    expect(array.my_any?(&true_block)).to eql(array.any?(&true_block))
    expect(array.my_any?(&block)).to eql(array.any?(&block))
    expect(true_any_array.my_any?(true)).to eql(true_any_array.any?(true))
    expect(false_any_array.my_any?).to eql(false_any_array.any?)
  end
end

describe '#my_map' do
  it 'returns the result of manipulation on an array to different array' do
    expect(array.my_map do |n|
             n * 4
           end).to eql([24, 76, 76, 100, 28, 120, 80, 108, 88, 76, 72, 116, 48, 124, 8, 48, 0, 128, 4, 80])
  end
  it 'return enum if no block' do
    expect(array.my_map).to be_a(Enumerator)
  end
end

describe '#my_inject' do
  it 'operates the operator over a collection and returns the result in single datatype' do
    expect(array.my_inject(:+)).to eql(351)
    expect(array.my_inject(1) { |r, i| r * i }).to eql(0)
  end
end
