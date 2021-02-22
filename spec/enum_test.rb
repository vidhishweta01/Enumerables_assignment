require_relative '../test5'
include Enumerable # rubocop:disable Style/MixinUsage

array = [6, 19, 19, 25, 7, 30, 20, 27, 22, 19, 18, 29, 12, 31, 2, 12, 0, 32, 1, 20]
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
    array.my_each_with_index do |x, i|
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