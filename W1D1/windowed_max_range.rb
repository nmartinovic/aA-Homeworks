
#time_complexity = O(n) or O(n^2) depending on how max and min work
#space_complexity = O(n)
def naive_max_windowed_range(array, window_size)
    current_max_range = -1.0/0.0

    array.each_with_index do |start, start_index|
        if start_index + window_size > array.length
            return current_max_range
        end
        temp = array[start_index...start_index+window_size]
        max = temp.max
        min = temp.min
        if (max-min) > current_max_range
            current_max_range = max-min
        end
    end
    current_max_range
end


class MyQueue

    def initialize
        @store = []
    end

    def peek
        @store[0]
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def enqueue(ele)
        @store.push(ele)
    end

    def dequeue
        @store.shift
    end
end

class MyStack

    def initialize
        @store = []
    end

    def peek
        @store[-1]
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def pop
        @store.pop
    end

    def push(ele)
        @store.push(ele)
    end

end

class StackQueue
    
    def initialize
        @in = MyStack.new
        @out = MyStack.new
    end

    def size
        @in.size + @out.size
    end

    def empty?
        @in.empty? && @out.empty?
    end

    def enqueue(ele)
        @in.push(ele)
    end

    def dequeue
        if @out.empty?
            reverse_queue
            @out.pop
        else
            @out.pop
        end
    end

    def reverse_queue
        until @in.empty?
            @out.push(@in.pop)
        end
    end
end