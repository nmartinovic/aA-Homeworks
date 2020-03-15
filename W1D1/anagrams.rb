


#time_complexity = factorial 
def first_anagram?(word,anagram)
    word_array = word.split("")
    subarray = word_array.permutation.to_a
    subarray.include?(anagram.split(""))
    
end

#time_complexity = linear O(n)
def second_anagram?(word, anagram)
    word_array = word.split("")
    anagram_array = anagram.split("")

    word_array.each do |letter|
        if anagram_array.find_index(letter) != nil
            anagram_array.delete_at(anagram_array.find_index(letter))
        end
    end

    anagram_array.empty?

end

#time_complexity = I think it is nlogn
def third_anagram?(word,anagram)
    word.split("").sort == anagram.split("").sort
end

def fourth_anagram(word,anagram)
    word_hash = Hash.new(0)
    anagram_has = Hash.new(0)

    word.each_char do |letter|
        word_hash[letter] += 1
    end

    anagram.each_char do |letter|
        word_hash[letter] -= 1
    end
    word_hash.values.all?(0)
end