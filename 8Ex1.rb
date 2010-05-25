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
puts words.sort