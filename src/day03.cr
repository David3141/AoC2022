rucksacks = File.read_lines("inputs/day03.txt")

PRIORITIES = Hash.zip(
  ('a'..'z').to_a + ('A'..'Z').to_a,
  (1..52).to_a
)

def find_common_priority(str : String)
  left = str[...(str.size // 2)]
  right = str[(str.size // 2)...]

  element = nil

  left.each_char do |c|
    if right.includes? c
      element = c
      break
    end
  end

  PRIORITIES[element]
end

def find_common_priority(strings)
  first, second, third = strings

  element = nil

  first.each_char do |c|
    if second.includes?(c) && third.includes?(c)
      element = c
      break
    end
  end

  PRIORITIES[element]
end

result01 = rucksacks.map { |str| find_common_priority(str) }.sum
result02 = rucksacks.in_groups_of(3, "")
  .map { |group| find_common_priority(group) }.sum

puts result01
puts result02