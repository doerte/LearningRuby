var1 = 'stop' 
var2 = 'deliver repaid desserts'
var3 = '....TCELES B HSUP A magic spell?'
puts var1.reverse
puts var2.reverse
puts var3.reverse
puts var1
puts var2
puts var3

puts 'What is your full name?'
name = gets.chomp
puts 'Did you know there are ' + name.length.to_s + ' characters'
puts 'in your name, ' + name + '?'

puts 'What is your first name?'
fname = gets.chomp
puts 'And your middle name?'
mname = gets.chomp
puts 'And finally, your last name?'
lname = gets.chomp
fnamelet = fname.length  
mnamelet = mname.length  
lnamelet = lname.length
namelet = fnamelet + mnamelet + lnamelet
puts 'Did you know that you complete name consists of ' + namelet.to_s + ' letters?'