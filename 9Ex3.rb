 def new_roman num
	 thou = (num/1000)
	 hun = (num%1000/100)
	 ten = (num%100/10)
	 one = (num%10)
	 
	 roman = 'M' * thou
	 
	 if hun == 9
		 roman = roman  + 'CM'
	elsif hun == 4
		 roman = roman + 'CD'
	else
		 roman = roman + 'D' * (num%1000/500)
		 roman = roman + 'C' * (num%500/100)
	 end


	 if ten == 9
		 roman = roman + 'XC'
	 elsif ten == 4
		 roman = roman + 'XL'
	 else
		 roman = roman + 'L'* (num%100/50)
		 roman = roman + 'X' * (num%50/10)
	 end
	 
	 if one ==9
		 roman = roman + 'IX'
	 elsif one ==4
		 roman = roman + 'IV'
	 else
		 roman = roman + 'V'*(num%10/5)
		 roman = roman + 'I'*(num%5/1)
	 end
	 
	 roman
 end

 
puts 'please enter a number and this will return it in old roman numerals'
puts 'write "exit" to finish the program'

while true
	input = gets.chomp
	if input == 'exit'
	break
	else
		puts input.to_s + ' in new roman numerals is:'
		puts (new_roman(input.to_i)) 
		puts 'Please enter another number or "exit"'
	end
end



