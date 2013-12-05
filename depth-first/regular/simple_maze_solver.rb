require 'ruby-debug'

class Array
  def deep_freeze
      each { |j| j.deep_freeze if j.respond_to? :deep_freeze }
      freeze
  end
end

MAZE = File.open('./maze.txt', "r") do |file|
  lines = file.readlines
  lines.map{|line| line.chomp.split("")}
end.deep_freeze

class Maze
  attr_reader :paths
  attr_accessor :steps, :visited

  DIRECTIONS = [[0,-1],[0,1],[-1,0],[1,0]]

  def initialize
    @paths = File.open('./maze.txt', "r") do |file|
      lines = file.readlines
      lines.map{|line| line.chomp.split("")}
    end
    @steps = []
    @visited = []
  end

  def move(x,y)
    DIRECTIONS.shuffle.each do |direction|
      next_x = x + direction[0]
      next_y = y + direction[1]
      paths[x][y] = " "

      if can_move(next_x, next_y)
        paths[next_x][next_y] = "*"
        visited << [next_x, next_y]
        display paths
        move(next_x, next_y)
        if solution?
          paths[next_x][next_y] = "O"
          p visited
          Kernel.exit
        end
      else
        visited = [] unless solution?
      end
    end
  end

  def display(paths)
    puts
    paths.each do |array|
      array.each {|x| print "#{x} "}
      puts
    end
    puts "\e[H"
    sleep(0.5)
  end

  def reset
    @paths = File.open('./maze.txt', "r") do |file|
      lines = file.readlines
      lines.map{|line| line.chomp.split("")}
    end
  end

  def can_move(x, y)
    paths[x][y] == " " && visited.include?([x,y]) == false
  end

  def solution?
    paths[7][8] == "*" || paths[7][9] == "*"
  end
end

Maze.new.move(2,1) # because 2,1 is the start of the maze
