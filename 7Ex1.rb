bottle = 99


while bottle > 2
  puts  bottle.to_s + ' bottles of beer on the wall, ' + bottle.to_s + 'bottles of beer.'
  bottle = bottle - 1
  puts 'Take one down and pass it around, ' + bottle.to_s + ' bottles of beer on the wall.'

end

puts "2 bottles of beer on the wall, 2 bottles of beer!"
puts "Take one down, pass it around, 1 bottle of beer on the wall!"
puts "1 bottle of beer on the wall, 1 bottle of beer!"
puts "Take one down, pass it around, no more bottles of beer on the wall!"