class Day10
  def solve_1
    cycles = create_cycles

    [20, 60, 100, 140, 180, 220].map { |x| x * cycles[x - 1] }.sum
  end
  
  def solve_2
    4
  end

  private def create_cycles
    x = 1
    cycles = [] of Int32

    input.each do |line|
      if line == "noop"
        cycles.push x
        next
      end

      cycles += [x, x]

      _, num_str = line.split
      x += num_str.to_i
    end

    cycles
  end

  private def input
    File.read_lines("inputs/day10.txt")
  end
end