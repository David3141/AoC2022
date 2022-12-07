rounds = File.read_lines("inputs/day02.txt")
  .map(&.split.map { |c| rps_to_num(c) })

def rps_to_num(rps : String)
  case rps
  when "A", "X" then 1
  when "B", "Y" then 2
  else 3
  end
end

def score01(round)
  opponent, me = round

  # https://eduherminio.github.io/blog/rock-paper-scissors/
  case opponent - me
  when -1, 2 # I win
    6 + me
  when 0 # draw
    3 + me
  else # I lose
    0 + me
  end
end

def score02(round)
  opponent, result = round
  chain = [1, 2, 3, 1, 2]

  me =
    case result
    when 1 # I lose
      chain[opponent + 1]
    when 2 # draw
      opponent
    else # I win
      chain[opponent]
    end

  score01([opponent, me])
end

result01 = rounds.map { |round| score01(round) }.sum
result02 = rounds.map { |round| score02(round) }.sum

puts result01
puts result02
