class Directory
  getter dirs : Array(Directory)
  getter files : Array(Tuple(String, Int32))
  getter name : String
  getter parent : Directory | Nil

  def initialize(name, parent)
    @dirs = [] of Directory
    @files = [] of Tuple(String, Int32)
    @name = name
    @parent = parent
  end

  def full_path
    path = name
    current_parent = self.parent

    while current_parent.is_a?(Directory)
      path = "#{current_parent.name}/#{path}"
      current_parent = current_parent.parent
    end

    path
  end

  def size : Int32
    files_size = files.map(&.[1]).sum
    directories_size = dirs.map(&.size).sum

    files_size + directories_size
  end
end

class Day07
  CD_DIR        = /^\$ cd ([a-zA-Z0-9]+)$/
  DIR_NAME      = /^dir ([a-zA-Z0-9]+)$/
  SIZE_AND_FILE = /^(\d+) ([a-zA-Z0-9\.]+)$/

  def parse_input
    result = {
      "/" => Directory.new("/", nil),
    }

    current_directory = result["/"]

    File.read_lines("inputs/day07.txt").each do |line|
      next unless current_directory

      if CD_DIR.match(line)
        current_directory = current_directory.dirs.find { |dir| dir.name == $1 }
        next
      end

      if line == "$ cd .."
        current_directory = current_directory.parent
        next
      end

      if DIR_NAME.match(line)
        new_directory = Directory.new($1, current_directory)
        current_directory.dirs.push(new_directory)
        result[new_directory.full_path] = new_directory
        next
      end

      if SIZE_AND_FILE.match(line)
        current_directory.files.push({$2, $1.to_i})
        next
      end
    end

    result
  end

  def solve_1
    parse_input
      .select { |key, dir| dir.size <= 100_000 }
      .map { |key, dir| dir.size }
      .sum
  end

  def solve_2
    all_directories = parse_input

    total_space = 70_000_000
    space_needed = 30_000_000
    used_space = all_directories["/"].size
    free_space = total_space - used_space
    space_to_delete = space_needed - free_space

    _, dir_to_delete = all_directories
      .select { |key, dir| dir.size >= space_to_delete }
      .min_by { |key, dir| dir.size }

    dir_to_delete.size
  end
end
