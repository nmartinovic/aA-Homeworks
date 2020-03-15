class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_accessor :head, :tail
  def initialize
    @head = Node.new(:head,:head)
    @tail = Node.new(:tail,:tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    count = 0
    self.each do |node|
      if count == i
        return node
      else
        count += 1
      end
    end
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    if @head.next == @tail
      return true
    else
      return false
    end
  end

  def get(key)
    node = first
    until node == @tail
      return node.val if node.key == key
      node = node.next
    end
    nil
  end

  def include?(key)
    self.each do |node|
      if node.key == key
        return true
      end
    end
    false
  end


  def append(key, val)
    new_node = Node.new(key,val)
    if empty?
      @head.next, @tail.prev = new_node, new_node
      new_node.prev, new_node.next = @head, @tail
    else
      old_node = @tail.prev
      old_node.next = new_node
      new_node.prev = old_node
      new_node.next = @tail
      @tail.prev = new_node
    end

  end

  def update(key, val)
    node = @head
    until node.key == key || node.next == @tail
      node = node.next
    end
    if node.key == key
      node.val = val
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.prev.next = node.next
        node.next.prev = node.prev
        break
      end
    end

  end

  def each
    node = @head.next
    until node == @tail
      yield(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
