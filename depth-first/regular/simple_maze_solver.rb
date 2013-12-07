puts `clear`

MAZE = File.open('./maze.txt', "r") do |file|
  lines = file.readlines
  lines.map{|line| line.chomp.split("")}
end

class Maze
  attr_reader :paths

  DIRECTIONS = [[0,-1],[0,1],[-1,0],[1,0]]

  def initialize
    @paths = File.open('./maze.txt', "r") do |file|
      lines = file.readlines
      lines.map{|line| line.chomp.split("")}
    end
  end

  def move(x,y)
    DIRECTIONS.shuffle.each do |direction|
      next_x = x + direction[0]
      next_y = y + direction[1]
      paths[x][y] = "*"

      if [next_x, next_y] == solution?
        paths[next_x][next_y] = "X"
        display paths
        exit
      end

      if can_move(next_x, next_y)
        display paths
        move(next_x, next_y)
      end

      paths[x][y] = " "
      end
    end

  def display(paths)
    puts
    paths.each do |array|
      array.each {|x| print "#{x} "}
      puts
    end
    puts "\e[H\e[?25l"
    sleep(0.2)
  end

  def can_move(x, y)
    paths[x][y] == " "
  end

  def solution?
    [7,10]
  end
end

Maze.new.move(2,1) # because 2,1 is the start of the maze