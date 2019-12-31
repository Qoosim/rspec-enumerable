# rubocop:disable all

module Enumerable

  # my_each method that prints the square of every elements in an array 
  def my_each
    return to_enum(:my_each) unless block_given?

    k = 0
    while k < size
      yield self[k]
      k += 1
    end
    self
  end

  # my_each_with_index that prints double of each element of a particular position
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    k = 0
    while k < size
      yield(self[k], k)
      k += 1
    end
  end

  # my_select method that outputs even numbers of the given array
  def my_select
    return to_enum(:my_select) unless block_given?
  
    new_arr = []
    my_each { |element| new_arr << element if yield(element) }
    new_arr

  end

  def my_all?(*arg)
    return grep(arg.first).length == size unless arg.empty?

    my_each { |el| return false unless yield(el) } if block_given?

    my_each { |el| return false unless el } unless block_given?

    true
  end

  def my_any?(*arg)
    return !grep(arg.first).empty? unless arg.empty?

    my_each { |el| return true if yield(el) } if block_given?

    my_each { |el| return true if el } unless block_given?

    false
  end

  def my_none?(*arg)
    return grep(arg.first).empty? unless arg.empty?

    my_each { |el| return false if yield(el) } if block_given?

    my_each { |el| return false if el } unless block_given?

    true
  end

  def my_count(*arg)
    return my_select { |el| el == arg.first }.length unless arg.empty?

    return my_select { |el| yield el }.length if block_given?

    size
  end

  # my_map method that output the trasformed of a given array
  def my_map
    return to_enum(:my_map) unless block_given?

    k = 0
    trans_array = []
    while k < size
      trans_array << yield(self[k])
      k += 1
    end
    trans_array
  end

  # my_inject method that prints the sum of all the elements of a given array
  def my_inject(*arg)
    res = nil
    if arg.first && [Integer, Float].include?(arg.first.class)
      res = arg.first
      arr = to_a
    else
      res = first
      arr = to_a[1..-1]
    end
    if block_given?
      arr.my_each { |el| res = yield(res, el) }
    elsif arg.last.is_a? Symbol
      arr.my_each { |el| res = arg.last.to_proc.call(res, el) }
    else
      res = to_enum
    end
    res
  end
end

def multiply_els(arr)
  arr.my_inject(1) {|initial, num| initial * num}
end

array_each = [2, 5, 6, 3, 8]
array_index = [3, 8, 7, 9]
array_select = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
array_inject = [4, 6, 9, 6, 2]
array_count = [1, 2, 4, 2]
array_all = ['animal', 'mamma', 'reptile', 'cat', 'fish']
animals = ["cat", "dog", "cow", "ram", "hen"]
my_proc = Proc.new {|k| k*2}

p array_all.my_all?{|word| word.size <= 5}
array_each.my_each{|k| print "#{k**2} "}
puts
array_index.my_each_with_index{|k| print "#{k} "}
puts
p array_select.my_select{|even| even}
p array_count.my_count{|count| count}
p animals.my_map{|animal| animal.capitalize}
p array_each.my_map(&my_proc)
p array_inject.my_inject(0){|sum, num| sum += num}
p multiply_els(array_inject)

p [1, 2, 3, 3].my_all?{ |num| num  < 5 }
p %w["ant", "bat", "cat", "dog"].my_none?{ |word| word.length < 3}


# rubocop:enable all
