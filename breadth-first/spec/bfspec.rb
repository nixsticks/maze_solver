require_relative '../maze'
require_relative '../solver'

describe Maze do
  my_maze = File.open('../../maze.txt', "r") do |file|
    lines = file.readlines
    lines.map{|line| line.chomp.split("")}
  end

  let(:maze) { Maze.new(my_maze) }

  describe '#initialize' do
    it 'should set up the maze' do
      expect(maze.pathways).to be_a_kind_of(Array)
    end
  end

  describe '#can_move?' do
    it 'should tell you if you can move in a particular direction' do
      expect(maze.can_move?()).to eq(false)
    end
  end
end

describe Solver do
  it 'should keep track of possible solutions' do
  end

  it 'should' do
  end
end


# queue = [root]
# best = -1
# begin
#   current = queue.shift
#   best = [current, best].max
#   current.children.each {|child| queue.push child }
# end until queue.empty?