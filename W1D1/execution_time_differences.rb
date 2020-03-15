    list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]

def phase_one(input)
    #time_complexity = O(n**2)
    min = input.first
    input.each do |n1|
        input.each do |n2|
            if n2 < n1 && n2 < min
                min = n2
            end
        end
    end
    min

end

def phase_two(input)
    #time_complexity = O(n)
    min = input.first
    input.each do |n1|
        if n1 < min
            min = n1
        end
    end
    return min

end

    list1 = [5, 3, -7]  #8
    list2 = [2, 3, -6, 7, -6, 7]  #8
    list3 = [-5, -1, -3]  #-1



def phase_three(input)
    #time_complexity = O(n**2)
    subarrays = []
    value = input.first

    input.each_with_index do |num, num_i|
        input.each_with_index do |num2, num2_i|
            if num2_i >= num_i
                subarrays << input[num_i..num2_i]
            end
        end

    end

    subarrays.each do |sub|
        if sub.sum > value
            value = sub.sum
        end
    end
    value
end


def phase_four(numbers)
    best_sum = -1.0/0.0  # or: float('-inf')
    current_sum = 0
    numbers.each do |x|
        current_sum = [x, current_sum + x].max
        best_sum = [best_sum, current_sum].max
    end
    return best_sum
end