#This is a crappy implementation since it is O(n)

class LRUCache
    def initialize(cache_size)
        @cache_size = cache_size
        @cache = []
    end

    def count
      # returns number of elements currently in cache
      @cache.count
    end

    def add(ele)
      # adds element to cache according to LRU principle
        if @cache.find_index(ele) == nil
            if @cache.length == @cache_size
                @cache.shift
            end
            @cache << ele
        else @cache.delete_at(@cache.find_index(ele))
            @cache << ele
        end
    end

    def show
      # shows the items in the cache, with the LRU item first
      @cache
    end

    private
    # helper methods go here!


  end