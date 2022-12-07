# ["1-2,3-5"] -> [[1, 2], [3, 5]]
boundary_pairs = File.read_lines("inputs/day04.txt")
  .map(&.split(',').map(&.split('-').map(&.to_i)))

result01 = boundary_pairs.count do |pair|
  first, second = pair
  min1, max1 = first
  min2, max2 = second

  first_is_in_second = min1 >= min2 && max1 <= max2
  second_is_in_first = min2 >= min1 && max2 <= max1

  first_is_in_second || second_is_in_first
end

puts result01
