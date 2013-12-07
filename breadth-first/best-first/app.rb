require_relative 'maze'
require_relative 'solver'
require_relative 'queue'

maze = File.open('./maze.txt', "r") do |file|
  lines = file.readlines
  lines.map{|line| line.chomp.split("")}
end

def branches(solver)
  solver.next_nodes.reject{|node| @visited.include?(node.maze.paths)}.shuffle
end

def solve(maze)
  @visited = []
  @queue = Queue.new {|state| state.cost}
  solver = Solver.new(maze)
  loop do
    @visited << solver.maze.paths
    break if solver.solution?
    branches(solver).each {|node| @queue << node}
    solver = @queue.next
  end
  solver
end

def animation(solution)
  path = solution.path
  solution.path.each do |direction|

  end
end

solved = solve(Maze.new(maze))
p solved.path
solved.maze.paths.each do |path|
  path.each {|x| print "#{x} "}
  puts
end