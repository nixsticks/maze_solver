require 'ruby-debug'

MAZE = File.open('./maze.txt', "r") do |file|
  lines = file.readlines
  lines.map{|line| line.chomp.split("")}
end

class Maze
  attr_reader :paths

  START = MAZE[2][1]
  SOLUTION = MAZE[7][8]

  def initialize(paths)
    @paths = paths
  end

  def position
    current = []
    paths.each do |path|
      path.each {|slot| current = [paths.index(path), path.index(slot)] if slot == "o" }
    end
    current
    # paths[current[0]][current[1]]
  end

  def move(x, y)
    new_paths = Marshal.load( Marshal.dump(paths))
    new_paths[position[0]][position[1]] = "*"
    new_paths[x][y] = "o"
    Maze.new(new_paths)
  end

  def can_move(x, y)
    paths[x][y] == " "
  end

  def solution?
    paths[7][8] == "o"
  end
end

class State
  DIRECTIONS = [:left, :right, :up, :down]

  attr_accessor :maze, :path

  def initialize(maze, path=[])
    @maze = maze
    @path = path
  end

  def solution?
    maze.solution?
  end

  def branches
    # returns an array of the different possibilities.
    DIRECTIONS.map{|direction| move_toward(direction)}.compact.shuffle
  end

  def move_toward(direction)
    position = maze.position
    x = position[0]
    y = position[1]
    case direction
    when :left
      y -= 1
    when :right
      y += 1
    when :up
      x -= 1
    when :down
      x += 1
    end

    State.new(maze.move(x,y), @path + [direction]) if maze.can_move(x, y)
  end
end

def search(state)
  unvisited = state.branches.reject{|branch| @visited.include? branch.maze.paths}.shuffle
  unvisited.each{|branch| @frontier << branch}
end

require 'set'
def solve(maze)
  @visited = Set.new
  @frontier = []
  state = State.new(maze)
  loop do
    @visited << state.maze.paths
    break if state.solution?
    search(state)
    # debugger
    state = @frontier.shift
    # p @frontier
  end
  state
end

solved = solve(Maze.new(MAZE))
p solved.path
solved.maze.paths.each do |path|
  path.each {|x| print "#{x} "}
  puts
end
