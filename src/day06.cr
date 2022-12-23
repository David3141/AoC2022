class Day06
  def solve_1
    find_earliest_index_of_n_unique_chars(4)
  end

  def solve_2
    find_earliest_index_of_n_unique_chars(14)
  end

  private def find_earliest_index_of_n_unique_chars(n)
    str = File.read("inputs/day06.txt")
    char_count = n

    Char::Reader.new(str).each_cons(n) do |substr|
      break if substr.uniq.size == n
      char_count += 1
    end

    char_count
  end
end
