class Day10
  def solve_1
    cycles = create_cycles

    [20, 60, 100, 140, 180, 220].map { |x| x * cycles[x - 1] }.sum
  end

  def solve_2
    cycles = create_cycles
    crt = Array.new(240) { |n| n }
    result = ""

    cycles.zip(crt) do |sprite_pos, crt_pos|
      pixel = (sprite_pos - crt_pos % 40).abs <= 1 ? '#' : '.'
      result += pixel
    end

    Char::Reader.new(result).in_groups_of(40).each do |line|
      puts line.join
    end

    "⬆️"
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