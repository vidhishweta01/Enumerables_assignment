# Enumerables_assignment

![Screenshot](./assets/Screenshot.png)


Enumerable_assignment contains the customised method which behave as original methods
can be used as example below:
here array can be any Array or range these method behave as original methods
  array.my_each do |i|
    r = r+i
  end
  print r
  arr.my_each{|r| puts r if r != 6}
  array.my_each_with_index{ |r, i| puts i if r != 6}
  print(array.my_select{|n| n > 7})
  p array.my_none? {|n| n == 3 }
  p array.my_all? {|n| n == 3 }
  p array.my_any? {|n| n == 3 }
  p array.my_count(4)
  p array.my_map{|n| n*4} 
  print(array.my_inject(:*))
  p arr.my_inject(1) { |r, i| r * i }
  p array.my_none?(Integer)
  p array.my_all?(Integer)
  p array.my_any?(String)
   arr =["ruby"]
  p arr.all?(/r/)
  p arr.my_all?(/r/)
  p arr.none?(/r/)
  p arr.my_none?(/r/)
  p arr.my_any?(/r/)
  p arr.any?(/r/)
  block = proc { |num| num <  2 }
  false_block = proc { |num| num > 9 }
true_block = proc { |num| num <= 9 }
  p array.my_count(&false_block)
  p array.count(&false_block)
  p array.my_none?(23)
  p array.none?(23)
  words = %w[programmer computer house car]
  p words.my_none?("to")
  p words.none?("to")
  p array.all?(Integer)
  p array.my_all?(Integer)
  p array.any?(7)
  p array.my_any?(7)
  words = %w[programmer computer house car]
  puts
  p words.all?("car")
  p words.my_all?("car")
  p words.any?("car")
  p words.my_any?("car")
  puts
  p words.all?(5)
  p words.any?(5)
  p words.my_any?(5)
  puts
  p words.my_none?("car")
  p words.none?("car")
  p words.my_any?("car")
  p words.any?("car")
  block = proc { |num| num <  2 }
  false_block = proc { |num| num > 9 }
true_block = proc { |num| num <= 9 }
  #p array.my_count(&false_block)
  p array.my_count(&block)
  p array.count(&block)
  puts
  p array.my_count
  p array.count
  arr =["ruby"]
  true_any_array = [nil, false, true, []]
  false_any_array = [nil, false, nil, false]
  true_array = [1, true, 'hi', []]
  false_array = [1, false, 'hi', []]
  puts
  p false_array.all?(false)
  p false_array.my_all?(false)
  puts
  p true_any_array.none?(true)
  p true_any_array.my_none?(true)
  puts
  p true_any_array.all?([])
  p true_any_array.my_all?([])
  p [true,[true],false].all? == [true,[true],false].my_all?
  p (1..3).any?(&proc{|x| x==0})==(1..3).my_any?(&proc{|x| x==0})
  p [false, 0].any? == [false, 0].my_any?
  p (1..3).none?(&proc{|num| num%2==0})==(1..3).my_none?(&proc{|num| num%2==0})
  p [false, nil,false].none? ==  [false, nil,false].my_none?
  false_block = proc { |num| num > 9 }
  rang = Range.new(5, 10)
  p rang.my_any?(&false_block) == rang.any?(&false_block)
  p (1..3).any?(&proc{|x| x==0}) == (1..3).my_any?(&proc{|x| x==0})
  false_array = [1, false, 'hi', []]
  p false_array.my_any? == false_array.any?
  true_array = [1, true, 'hi', []]
  p true_array.my_none? == true_array.none?

multiply_els method can take input as array or range
  
## Built with

ruby

## Authors 👤

### Shweta Srivastava

_[Github](https://github.com/vidhishweta01)

_[LinkedIn](http://linkedin.com/in/shweta-s-15a57070)

## Show your support ⭐️⭐️

Give a star if you like this project!

## License 📝

This project is [MIT](https://www.mit.edu/~amini/LICENSE.md) licensed.