class Day05
  private def parse_input
    stacks_str, commands_str = File.read("inputs/day05.txt").split("\n\n")
    max_line_length = stacks_str.lines.map(&.size).max

    stacks = stacks_str.lines
      .map(&.ljust(max_line_length, ' ').each_char.to_a)
      .transpose.map(&.reverse.select(&.alphanumeric?))
      .reject(&.empty?)

    commands = commands_str.lines.map do |line|
      matches = /move (\d+) from (\d) to (\d)/.match(line)
      next unless matches

      matches[1..3].map(&.to_i)
    end.compact

    {stacks, commands}
  end

  def solve_1
    stacks, commands = parse_input

    commands.each do |command|
      count, from, to = command

      count.times do
        element = stacks[from - 1].pop
        stacks[to - 1].push(element)
      end
    end

    stacks.map(&.last).join("")
  end

  def solve_2
    stacks, commands = parse_input

    commands.each do |command|
      count, from, to = command

      elements = stacks[from - 1].pop(count)
      stacks[to - 1].concat(elements)
    end

    stacks.map(&.last).join("")
  end
end
