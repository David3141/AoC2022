class Day01
  def solve_1
    input.map(&.sum).max
  end

  def solve_2
    input.map(&.sum).sort.last(3).sum
  end

  private def input
    File.read("inputs/day01.txt")
      .split("\n\n")
      .map(&.lines.map(&.to_i))
  end
end
