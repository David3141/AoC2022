require "benchmark"

class Day09
  enum Direction
    Up
    Down
    Left
    Right
  end

  private def parse_input
    File.read_lines("inputs/day09.txt").map do |line|
      direction = case line[0]
                  when 'U' then Direction::Up
                  when 'D' then Direction::Down
                  when 'L' then Direction::Left
                  else Direction::Right
                  end

      distance = line[2..].to_i

      { direction, distance }
    end
  end

  def solve_1
    tail_positions = [] of Tuple(Int32, Int32)
    head_x = 0
    head_y = 0
    tail_x = 0
    tail_y = 0

    parse_input.each do |(direction, distance)|
      distance.times do
        case direction
        when Direction::Up
          head_y += 1
  
          delta_x = (head_x - tail_x).abs
          delta_y = (head_y - tail_y).abs
      
          if delta_y >= 2
            tail_y += 1

            if delta_x >= 1
              if head_x > tail_x
                tail_x += 1
              else 
                tail_x -= 1
              end
            end
          end
        when Direction::Down
          head_y -= 1
  
          delta_x = (head_x - tail_x).abs
          delta_y = (head_y - tail_y).abs
      
          if delta_y >= 2
            tail_y -= 1

            if delta_x >= 1
              if head_x > tail_x
                tail_x += 1
              else 
                tail_x -= 1
              end
            end
          end
        when Direction::Left
          head_x -= 1
  
          delta_x = (head_x - tail_x).abs
          delta_y = (head_y - tail_y).abs
      
          if delta_x >= 2
            tail_x -= 1

            if delta_y >= 1
              if head_y > tail_y
                tail_y += 1
              else 
                tail_y -= 1
              end
            end
          end
        else
          head_x += 1
  
          delta_x = (head_x - tail_x).abs
          delta_y = (head_y - tail_y).abs
      
          if delta_x >= 2
            tail_x += 1

            if delta_y >= 1
              if head_y > tail_y
                tail_y += 1
              else 
                tail_y -= 1
              end
            end
          end
        end

        tail_positions.push({ tail_x, tail_y })
      end
    end

    tail_positions.uniq.size
  end

  def solve_2
    0
  end

  private def update_position(head, tail, command)
    direction, distance = command

    new_head = 
      case direction
      when Direction::Up 
        { head[0], head[1] - distance }
      when Direction::Down 
        { head[0], head[1] + distance }
      when Distance::Left 
        { head[0] - distance, head[1] }
      else 
        { head[0] + distance, head[1] }
      end
  end

  private def go_up(head, tail, distance)
    head_x, head_y = head
    tail_x, tail_y = tail
  
    distance.times do 
      head_y += 1
  
      Δx = (head_x - tail_x).abs
      Δy = (head_y - tail_y).abs
  
      tail_x += 1 if Δx >= 1 && Δy >= 2
      tail_y += 1 if Δy >= 2
  
      TAIL_POSITIONS.push({ tail_x, tail_y })
    end
  
    {
      {head_x, head_y},
      {tail_x, tail_y}
    }
  end
end
