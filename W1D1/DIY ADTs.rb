class Stack

    def initialize
      # create ivar to store stack here!
      @stack = []
    end

    def push(el)
      # adds an element to the stack
      @stack.unshift(el)
    end

    def pop
      # removes one element from the stack
      @stack.shift
      @stack
    end

    def peek
      # returns, but doesn't remove, the top element in the stack
      @stack[0]
    end
end


class Queue

  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue << el
    @queue
  end

  def dequeue
    @queue.shift
    @queue
  end

  def peek
    @queue[0]
  end
end

class Map

  def initialize
    @map = []
  end

  def set(key,value)
    @map.each do |subarray|
      if subarray[0] == key
        subarray[1] = value
        return @map
      end
    end
    @map << [key,value]
  end

  def get(key)
    pair = @map.select { |subarray| subarray[0] == key }
    pair.flatten
  end

  def delete(key)
    @map = @map.select { |subarray| subarray[0] != key }
  end

  def show
    @map[0]
  end
end