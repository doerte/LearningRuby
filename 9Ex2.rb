 def old_roman num
	 roman =''
	 
	 roman = roman + 'M' * (num/1000)
	 roman = roman + 'D' * (num%1000/500)
	 roman = roman + 'C' * (num%500/100)
	 roman = roman + 'L' * (num%100/50)
	 roman = roman + 'X' * (num%50/10)
	 roman = roman + 'V' * (num%10/5)
	 roman = roman + 'I' * (num%5/1)
 end
 
puts 'please enter a number and this will return it in old roman numerals'
puts 'write "exit" to finish the program'

while true
	input = gets.chomp
	if input == 'exit'
	break
	else
		puts input.to_s + ' in old roman numerals is:'
		puts (old_roman(input.to_i)) 
		puts 'Please enter another number or "exit"'
	end
end


