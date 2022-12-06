rounds = File.read_lines("inputs/day02.txt").map(&.split)

def score(round : Array(String))
  opponent, me = round

  if opponent == "A"
    return 3 if me == "X"
    return 6 if me == "Y"
    return 0 if me == "Z"
  end

  if opponent == "B"
    return 0 if me == "X"
    return 3 if me == "Y"
    return 6 if me == "Z"
  end

  return 6 if me == "X"
  return 0 if me == "Y"
  return 3
end

def numeric_value(letter : String)
  case letter
  when "X" then 1
  when "Y" then 2
  else 3
  end
end

result01 = rounds.map { |round| score(round) + numeric_value(round[1]) }.sum

puts result01
