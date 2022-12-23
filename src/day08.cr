def parse_input
  File.read_lines("inputs/day08.txt").map do |line|
    Char::Reader.new(line).map &.to_i
  end
end

def solve_1
  input = parse_input
  max_x = input[0].size - 1
  max_y = input.size - 1

  count_visible = 0

  input.each.with_index do |row, y|
    row.each.with_index do |tree, x|
      is_edge = x == 0 || y == 0 || x == max_x || y == max_y
      is_visible = row[...x].all? &.<(tree) ||
                   row[x + 1..].all? &.<(tree) ||
                   input[...y].all? { |y_row| y_row[x] < tree } ||
                   input[y + 1..].all? { |y_row| y_row[x] < tree }

      count_visible += 1 if is_edge || is_visible
    end
  end

  count_visible
end

puts solve_1
