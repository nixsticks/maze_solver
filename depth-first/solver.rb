class Solver
  DIRECTIONS = [:left, :right, :up, :down]

  attr_accessor :maze, :path

  def initialize(maze, path=[])
    @maze = maze
    @path = path
  end

  def solution?
    maze.solution?
  end

  def next_nodes
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

    Solver.new(maze.move(x,y), @path + [direction]) if maze.can_move(x, y)
  end
end