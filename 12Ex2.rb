puts 'Please tell me when you were born!'
puts 'First the year'
y = gets.chomp.to_i
puts 'Then the month (1-12)'
m = gets.chomp.to_i
puts 'Now the day (1-31)'
d = gets.chomp.to_i
birthday = Time.local(y, m, d)
now = Time.new
age = 1

while Time.local(y + age, m, d) <= now
	puts 'SPANK!'
	age = age +1
end