groups = File.read("inputs/day01.txt")
  .split("\n\n")
  .map(&.lines.map(&.to_i))

result01 = groups.map(&.sum).max
result02 = groups.map(&.sum).sort.last(3).sum

puts result01
puts result02
