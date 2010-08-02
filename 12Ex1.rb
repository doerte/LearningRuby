puts 'Please enter your exact time of birth'
puts 'First the year'
y = gets.chomp
puts 'Then the month (1-12)'
m = gets.chomp
puts 'Now the day (1-31)'
d = gets.chomp
puts 'The hour... (0-24)'
h = gets.chomp
puts 'The minute... (0-59)'
mi = gets.chomp
puts 'And if you know the second... (0-59), write "0" if you don\'t know!'
s = gets.chomp
puts 'yyyy, mm, dd, hh, mm, ss'
birthtime = Time.local(y, m, d, h, mi, s)
puts birthtime
puts "You'll be 1 billion seconds on #{birthtime + 1000000000}"

