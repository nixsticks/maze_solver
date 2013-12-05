class Queue
  attr_accessor :elements

  def initialize &sorter
    @sorter = sorter
    @elements = []
  end

  def << element
    elements << element
    sort
  end

  def next
    elements.shift
  end

  def sort
    elements = elements.sort_by &@sorter if elements
  end
end