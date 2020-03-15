# class Integer
#   # Integer#hash already implemented for you
# end

# # class Array
# #   def hash
# #     self.hash
# #     # start = 0
# #     # self.flatten!
# #     # self.each_with_index do |ele,i|
# #     #   start += (ele.hash * i)
# #     # end
# #     # start
# #   end
  
# # end

# class String
#   def hash
#     hash_value = self.split("")
#     hash_value.map! { |ele| ele.unpack("B8") }
#     hash_value.flatten!
#     hash_value.map! { |ele| ele.to_i }
#     hash_value.hash
#   end
# end

# class Hash
#   # This returns 0 because rspec will break if it returns nil
#   # Make sure to implement an actual Hash#hash method
#   def hash
#     hash = self.to_a
#     hash.sort!
#     hash.hash
#     #0
#   end
# end
