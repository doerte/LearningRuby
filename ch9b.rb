def say_moo
  puts 'moooooooo...'
end

say_moo
say_moo
puts 'coin-coin'
say_moo
say_moo

puts''

def say_moo number_of_moos
  puts 'moooooooo...'*number_of_moos
end

say_moo 3
puts 'oink-oink'
# This last line should give an error
# because the parameter is missing...
say_moo
