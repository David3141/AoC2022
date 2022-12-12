rucksacks = File.read_lines("inputs/day03.txt")

PRIORITIES = Hash.zip(
  ('a'..'z').to_a + ('A'..'Z').to_a,
  (1..52).to_a
)

def find_common_priority(str : String)
  left = str[...(str.size // 2)]
  right = str[(str.size // 2)...]

  common = Char::Reader.new(left).find { |c| right.includes? c }

  PRIORITIES[common]
end

def find_common_priority(strings)
  first, second, third = strings

  common = Char::Reader.new(first).find do |c|
    second.includes?(c) && third.includes?(c)
  end

  PRIORITIES[common]
end

result01 = rucksacks.map { |str| find_common_priority(str) }.sum
result02 = rucksacks.in_groups_of(3, "")
  .map { |group| find_common_priority(group) }.sum

puts result01
puts result02
