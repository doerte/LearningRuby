puts 'Put in words and this will return them in a shuffled order'

def shuffle array
	start = []
	while array.length > 0 
	
		rand_index = rand(array.length)
	
		curr_index = 0
		output = []
	
		array.each do |item|
			if curr_index == rand_index
				start.push item
			else
				output.push item
			end
	
			curr_index = curr_index + 1
		end

		array = output
	end

	start
end


words = []

while true
input = gets.chomp
  if input == ''
    break	
  else
    words.push input
  end	
end
puts 'Here\'s your shuffled list:'
puts shuffle(words)