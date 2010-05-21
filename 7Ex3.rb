puts 'This will give you all the leap years between (and including) two years'
puts 'Please indicate a starting year.'
syear = gets.chomp.to_i 
puts 'And what is the ending year?'
eyear = gets.chomp.to_i

puts 'These are the leap years:'

lyear = syear

while lyear <= eyear
	if lyear%4 == 0
		if lyear%100 != 0 || lyear%400 == 0
			puts lyear
		end
	end
	
	lyear = lyear +1
end