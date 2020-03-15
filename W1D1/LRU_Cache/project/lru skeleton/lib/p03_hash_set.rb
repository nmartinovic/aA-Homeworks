class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if count == num_buckets
      resize!
    end
    if include?(key) == false
      self[key.hash] << key.hash
      @count += 1
    end
  end

  def include?(key)
    if self[key.hash].include?(key.hash)
      true
    else
      false
    end
  end

  def remove(key)
    if include?(key)
      self[key.hash].delete(key.hash)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store += Array.new(num_buckets) { Array.new }
    @store.each do |bucket|
      bucket.each do |ele|
        bucket.delete(ele)
        @count -= 1
        insert(ele)
      end
    end
  end
end
