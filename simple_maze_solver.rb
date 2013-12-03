require 'ruby-debug'

MAZE = File.open('./maze.txt', "r") do |file|
  lines = file.readlines
  lines.map{|line| line.chomp.split("")}
end

class Maze
  attr_reader :paths
  attr_accessor :steps

  DIRECTIONS = {
    :left => [0,-1],
    :right => [0,1],
    :up => [-1,0],
    :down => [1,0]
  }

  def initialize(paths)
    @paths = paths
    @steps = []
  end

  # def position
  #   current = []
  #   paths.each do |path|
  #     path.each {|slot| current = [paths.index(path), path.index(slot)] if slot == "o" }
  #   end
  #   current
  # end

  def move(x,y)
    DIRECTIONS.each do |direction, delta|
      next_x = x + delta[0]
      next_y = y + delta[1]

      if can_move(next_x, next_y)
        paths[x][y] = "*"
        paths.each do |array|
          array.each {|x| print "#{x}"}
          puts
        end
        move(next_x, next_y) 
        exit if solution?
      end
    end
  end

  def can_move(x, y)
    paths[x][y] == " "
  end

  def solution?
    paths[7][8] == "*"
  end
end

Maze.new(MAZE).move(2,1) # because 2,1 is the start of the maze
