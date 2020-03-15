

# time complexity = O(n^2)
# space complexity = O(n)
def bad_two_sum?(array, target_sum)
    array.each_with_index do |n1,n1i|
        array.each_with_index do |n2, n2i|
            if n2i > n1i && n2 + n1 == target_sum
                return true
            end
        end
    end
    false
end

#time complexity = O(nlogn)
#space complexity = O(n)
def okay_two_sum(array,target)
    array.sort!
    array.each_with_index do |n1,n1i|
        if n1i != array.length-1 && array[n1i] + array[n1i+1] == target
            return true
        end
    end
    false

end


def hash_map_two_sum(array,target)
    hash = Hash.new(0)
    array.each do |num|
        hash[num] += 1
    end

    hash.each_key do |key|
        if target-key != key and hash[target-key] == 1
            return true
        elsif target-key == key and hash[target-key] >=2
            return true
        end
    end
    false

end