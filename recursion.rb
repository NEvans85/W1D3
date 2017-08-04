require 'byebug'

def range(num1, num2)
  return [] if num2 <= num1
  [num1] + range(num1 + 1, num2)
end

def sum_of_array_recur(arr)
  return arr[0] if arr.length <= 1
  arr.first + sum_of_array_recur(arr[1..-1])
end

def sum_of_array_iter(arr)
  arr.reduce(:+)
end

def exp(base, power)
  return 1 if power == 0
  base * exp(base, power - 1)
end

def exp2(base, power)
  return 1 if power == 0
  return base if power == 1
  power.even? ? exp2(base, power / 2)**2 : base * (exp2(base, (power - 1) / 2)**2)
end

def fibonacci(n)
  return [] if n < 1
  return [1] if n == 1
  return [1, 1] if n == 2
  prev_fib = fibonacci(n - 1)
  prev_fib << prev_fib[-1] + prev_fib[-2]
end

def permutations(arr)
  return [arr] if arr.length == 1
  perm = []
  arr.each_with_index do |el, idx|
    arr_to_perm = arr.dup
    arr_to_perm.delete_at(idx)
    perm += permutations(arr_to_perm).map { |a| a.unshift(el) }
  end
  perm
end

def bsearch(array, target)
  return nil if array.empty?
  mid = array.length / 2
  case array[mid] <=> target
  when -1 then bsearch(array[(mid + 1)..-1], target) + mid + 1
  when 1 then bsearch(array[0...mid], target)
  when 0
    return mid
  end
end



class Array

  def deep_dup
    return [] if length < 1
    result = []
    self.each do |el|
      if el.is_a?(Array)
        result << el.deep_dup
      else
        result << el
      end
    end
    result
  end

  # def subsets
  #   return [] if length == 0
  #   byebug
  #   prev_subset = self[0...-1].subsets
  #   # prev_subset += prev_subset.each
  #   prev_subset + prev_subset.map { |el| el << self[-1] }
  # end

  def subsets
    # debugger
    return [[]] if empty?
    prev_subset = self[0...-1].subsets
    new_subset = prev_subset.map { |el| el + [self.last] }
    prev_subset + new_subset
  end

  def merge_sort
    # debugger
    return self if length <= 1
    mid = length / 2
    self[0...mid].merge_sort.merge(self[mid..-1].merge_sort)
  end

  def merge(other_array)
    result = []
    until self.empty? && other_array.empty?
      case self.first <=> other_array.first
      when -1
        result << self.shift
      when 1
        result << other_array.shift
      when 0
        result << self.shift
        result << other_array.shift
      when nil
        if other_array.empty?
          result << self.shift
        else
          result << other_array.shift
        end
      end
    end
    result
  end

end

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  return Array.new(amount, 1) if coins.length == 1
  change = []
  (amount / coins.first).times do
    change << coins.first
    amount -= coins.first
  end
  change + greedy_make_change(amount, coins[1..-1])
end

def make_better_change(amount, coins = [25, 10, 5, 1])
  return [] if coins.empty?
  return nil if coins.all? { |coin| coin > amount }
  best_result = nil
  coins.each_with_index do |coin, idx|
    next if coin > amount
    amount_left = amount - coin
    best_remainder = make_better_change(amount_left, coins.drop(idx))
    next if best_remainder.nil?
    this_result = [coin] + best_remainder
    if best_result.nil? || (this_result.count < best_result.count)
      best_result = this_result
    end
  end
  best_result
end
