require "benchmark"

class Day08
  private def parse_input
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

  def count_visible(arr, n)
    count = 0

    arr.each do |elem|
      count += 1
      break if elem >= n
    end

    count
  end

  def scenic_score_for(input, x, y)
    max_x = input[0].size - 1
    max_y = input.size - 1

    count_left = 0
    count_right = 0
    count_down = 0
    count_up = 0

    subject = input[y][x]

    (x - 1).downto(0) do |i|
      count_left += 1
      break if input[y][i] >= subject
    end

    (x + 1).upto(max_x) do |i|
      count_right += 1
      break if input[y][i] >= subject
    end

    (y - 1).downto(0) do |i|
      count_up += 1
      break if input[i][x] >= subject
    end

    (y + 1).upto(max_y) do |i|
      count_down += 1
      break if input[i][x] >= subject
    end

    count_left * count_right * count_up * count_down
  end

  def solve_2
    input = parse_input
    current_max_scenic_score = 0

    input.map_with_index do |row, y|
      row.map_with_index { |_, x| scenic_score_for(input, x, y) }
    end.max_of(&.max)
  end
end
