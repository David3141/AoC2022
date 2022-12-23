class Day02
  def solve_1
    input.map { |round| score01(round) }.sum
  end

  def solve_2
    input.map { |round| score02(round) }.sum
  end

  private def input
    File.read_lines("inputs/day02.txt")
      .map(&.split.map { |c| rps_to_num(c) })
  end

  private def rps_to_num(rps : String)
    case rps
    when "A", "X" then 1
    when "B", "Y" then 2
    else               3
    end
  end

  private def score01(round)
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

  private def score02(round)
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
end
