class Directory
  property parent : Directory | Nil
  property dirs : Array(Directory)
  property files : Array(Tuple(String, Int32))
  getter name : String

  def initialize(name, parent)
    @name = name
    @parent = parent
    @dirs = [] of Directory
    @files = [] of Tuple(String, Int32)
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

CD_DIR = /^\$ cd ([a-zA-Z0-9]+)$/
DIR    = /^dir ([a-zA-Z0-9]+)/
FILE   = /^(\d+) ([a-zA-Z0-9\.]+)/

ALL_DIRS = {
  "/" => Directory.new("/", nil),
}

current_directory = ALL_DIRS["/"]

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

  if DIR.match(line)
    new_directory = Directory.new($1, current_directory)
    current_directory.dirs.push(new_directory)
    ALL_DIRS[new_directory.full_path] = new_directory
    next
  end

  if FILE.match(line)
    current_directory.files.push({$2, $1.to_i})
    next
  end
end

puts ALL_DIRS
  .select { |k, dir| dir.size <= 100_000 }
  .map { |k, dir| dir.size }
  .sum
