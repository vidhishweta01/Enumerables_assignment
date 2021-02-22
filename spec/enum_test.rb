require_relative '../test5'
include Enumerable # rubocop:disable Style/MixinUsage

array = [6, 19, 19, 25, 7, 30, 20, 27, 22, 19, 18, 29, 12, 31, 2, 12, 0, 32, 1, 20]
describe '#Enumerable.my_each' do
  it 'returns each element in array' do
    expect(array.my_each { |x| x + 1 }).to eql(array.each { |x| x + 1 })
  end
end
