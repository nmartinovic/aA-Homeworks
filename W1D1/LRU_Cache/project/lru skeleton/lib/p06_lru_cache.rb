require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_accessor :prc
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      #move node to end of list
      update_node!(key)
      #return the node value
    else
      val = @prc.call(key)
      new_node = @store.append(key,val)  
      @map.set(key,new_node)
    end
    eject!
    @store.get(key)
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(key)
    # suggested helper method; move a node to the end of the list
    @map.set(key,(@store.append(key,@store.get(key))))
    @store.remove(key)
  end


  def eject!
    if count > @max
      key = @store.first.key
      @store.remove(key)
      @map.delete(key)
    end
  end
end
