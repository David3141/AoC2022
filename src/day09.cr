require "benchmark"

class Day09
  private def parse_input
    File.read_lines("inputs/day09.txt").map do |line|
      direction = line[0]
      distance = line[2..].to_i

      { direction, distance }
    end
  end

  def solve_1
    tail_positions = [] of Tuple(Int32, Int32)
    head_x = 0
    head_y = 0
    tail = { 0, 0 }

    parse_input.each do |(direction, distance)|
      distance.times do
        case direction
        when 'U' then head_y += 1
        when 'D' then head_y -= 1
        when 'L' then head_x -= 1
        else head_x += 1
        end

        tail = follow({ head_x, head_y }, tail)

        tail_positions.push(tail)
      end
    end

    tail_positions.uniq.size
  end

  def solve_2
    0
  end

  private def follow(head, tail)
    head_x, head_y = head
    tail_x, tail_y = tail
  
    delta_x = head_x - tail_x
    delta_y = head_y - tail_y

    if delta_x.abs == 2 || delta_y.abs == 2
      tail_x += delta_x.sign
      tail_y += delta_y.sign
    end

    { tail_x, tail_y }
  end
end
