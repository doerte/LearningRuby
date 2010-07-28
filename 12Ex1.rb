puts 'Please enter your exact time of birth'
puts 'Use the following layout: '
puts 'yyyy, mm, dd, hh, mm, ss'
birthtime = gets.chomp
birthtime = Time.local(birthtime)
puts "You'll be 1 billion seconds on #{birthtime + 1000000000}"

