require_relative 'maze'
require_relative 'solver'
require 'ruby-debug'

maze = File.open('./maze.txt', "r") do |file|
  lines = file.readlines
  lines.map{|line| line.chomp.split("")}
end

def search(solver)
  unvisited = solver.next_nodes.reject {|node| @visited.include?(node.maze.paths)}.shuffle
  unvisited.each {|node| @queue << node}
end

def solve(maze)
  @visited = []
  @queue = []
  solver = Solver.new(maze)
  loop do
    @visited << solver.maze.paths
    break if solver.solution?
    search(solver)
    solver = @queue.shift
  end
  solver
end

solved = solve(Maze.new(maze))
p solved.path
solved.maze.paths.each do |path|
  path.each {|x| print "#{x} "}
  puts
end