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
    new_paths = paths.clone
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

# def search(state)
#   unvisited = []
#   state.branches.each do |branch|
#     unvisited << 
#   end
#   unvisited = state.branches.reject{|branch| @visited.include? branch.maze.paths}
#   unvisited.each{|branch| @frontier << branch}
# end

def search(state)
  unvisited = state.branches.reject{|branch| @visited.include? branch.maze.paths}.shuffle
  unvisited.each{|branch| @frontier << branch}
end

# def branch
#   new_branches = DIRECTIONS.map{|direction| move_toward(direction)}.compact
#   possible = []
#   new_branches.
#   unvisited = state.branches.reject{|branch| @visited.include? branch.maze.paths}
# end



require 'set'                           
def solve(maze)
  @visited = Set.new
  @frontier = []
  state = State.new(maze)
  loop do
    @visited << state.maze.paths
    break if state.solution?
    search(state)
    p state.path
    state.maze.paths.each do |array|
      array.each {|x| print "#{x} "}
      puts
    end
    state = @frontier.shift          
  end
  state
end

p solve(Maze.new(MAZE)).paths

# state: up, down, left, right
# can move if the space is a " " and not a "#"
