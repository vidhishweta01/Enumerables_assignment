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