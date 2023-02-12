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
    solve(size_of_tail: 1)
  end

  def solve_2
    solve(size_of_tail: 9)
  end

  private def solve(size_of_tail)
    tail = Array.new(size_of_tail, { 0, 0 })
    tail_end__positions = [] of Tuple(Int32, Int32)
    head_x = 0
    head_y = 0

    parse_input.each do |(direction, distance)|
      distance.times do
        case direction
        when 'U' then head_y += 1
        when 'D' then head_y -= 1
        when 'L' then head_x -= 1
        else head_x += 1
        end

        new_tail = [] of Tuple(Int32, Int32)

        [{ head_x, head_y }, *tail].each_cons_pair do |a, b|
          new_tail.push follow(a, b)
        end

        tail = new_tail

        tail_end__positions.push(tail.last)
      end
    end

    tail_end__positions.uniq.size
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
