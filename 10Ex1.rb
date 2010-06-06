def sort some_array
	rec_sort some_array, []
end

def rec_sort unsorted, sorted
	if unsorted.length <= 0
		return sorted
	end

	smallest = unsorted.pop
	still_unsorted = []
	unsorted.each do |tested_object|
		if tested_object < smallest
			still_unsorted.push smallest
			smallest = tested_object
		else
			still_unsorted.push tested_object
		end
	end
	

	sorted.push smallest
	rec_sort still_unsorted, sorted
end

#puts(sort(['can','feel','singing','like','a','can']))


puts 'Please enter as many words as you like, one word at a time finishing with "enter". Once you\'re done, press "enter" after an empty line!'
puts 'You will then get an alphabetically ordered list of the words you entered'

words = []

while true
input = gets.chomp
  if input == ''
    break	
  else
    words.push input
  end	
end
puts 'Here\'s your sorted list:'
puts sort(words)