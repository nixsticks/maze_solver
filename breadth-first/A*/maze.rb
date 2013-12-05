class Maze
  attr_reader :paths

  def initialize(paths)
    @paths = paths
  end

  def position
    current = []
    paths.each do |path|
      path.each {|slot| current = [paths.index(path), path.index(slot)] if slot == "o" }
    end
    current
  end

  def move(x, y)
    new_paths = Marshal.load(Marshal.dump(paths))
    new_paths[position[0]][position[1]] = "*"
    new_paths[x][y] = "o"
    Maze.new(new_paths)
  end

  def can_move(x, y)
    paths[x][y] == " "
  end

  def solution?
    paths[7][8] == "o" || paths[8][9] == "o"
  end

  def distance_to_solution
    solution1 = (position[0] - 7).abs + (position[1] - 8).abs
    solution2 = (position[0] - 8).abs + (position[1] - 9).abs
    solution1 > solution2 ? solution2 : solution1
  end
end