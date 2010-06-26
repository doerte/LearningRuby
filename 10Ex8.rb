def english_number number
	if number < 0 # No negative numbers.
		return 'Please enter a number that isn\'t negative.'
	end

	if number == 0
		return 'zero'
	end

	# No more special cases! No more returns!
	num_string = '' # This is the string we will return.
	ones_place = 	['one', 'two', 'three',
				'four', 'five', 'six',
				'seven', 'eight', 'nine']

	tens_place = 	['ten', 'twenty', 'thirty',
				'forty', 'fifty', 'sixty',
				'seventy', 'eighty', 'ninety']

	teenagers = 	['eleven', 'twelve', 'thirteen',
				'fourteen', 'fifteen', 'sixteen',
				'seventeen', 'eighteen', 'nineteen']
	zillions = 	       [['hundred', 	2],
				['thousand', 	3],
				['million',	6],
				['billion', 	9],
				['trillion',   	12]]

	# "left" is how much of the number
	# we still have left to write out.
	# "write" is the part we are
	# writing out right now.
	# write and left...get it? :)

	left = number
	
	while zillions.length > 0
		zil_pair = zillions.pop
		zil_name = zil_pair[0]
		zil_base = 10 ** zil_pair[1]
		
		write = left/zil_base
		left = left - write*zil_base
		
		if write > 0
		
			prefix = english_number write
			
			num_string = num_string + prefix + ' ' + zil_name
			
			if left > 0
				num_string = num_string + ' '
			end
		end
	end
	
	
	write = left/10 # How many tens left?
	left = left - write*10 # Subtract off those tens.
	
	if write > 0
		if ((write == 1) and (left > 0))
		# Since we can't write "tenty-two" instead of
		# "twelve", we have to make a special exception
		# for these.
			num_string = num_string + teenagers[left-1]
		# The "-1" is because teenagers[3] is
		# 'fourteen', not 'thirteen'.
		# Since we took care of the digit in the
		# ones place already, we have nothing left to write.

			left = 0
		else
			num_string = num_string + tens_place[write-1]
			# The "-1" is because tens_place[3] is
			# 'forty', not 'thirty'.
		end

		if left > 0
		# So we don't write 'sixtyfour'...
			num_string = num_string + '-'
		end
	end

	write = left # How many ones left to write out?
	left = 0 # Subtract off those ones.

	if write > 0
		num_string = num_string + ones_place[write-1]
		# The "-1" is because ones_place[3] is
		# 'four', not 'three'.
	end
	
	# Now we just return "num_string"...
	num_string
end


bottle = 99


while bottle > 2
  puts  english_number(bottle).capitalize + ' bottles of beer on the wall, ' + english_number(bottle) + 'bottles of beer.'
  bottle = bottle - 1
  puts 'Take one down and pass it around, ' + english_number(bottle) + ' bottles of beer on the wall.'

end

puts "Two bottles of beer on the wall, two bottles of beer!"
puts "Take one down, pass it around, one bottle of beer on the wall!"
puts "One bottle of beer on the wall, one bottle of beer!"
puts "Take one down, pass it around, no more bottles of beer on the wall!"