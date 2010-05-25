names = ['Ada', 'Belle', 'Chris']
puts names
puts
puts names[0]
puts names[1]
puts names[2]
puts names[3] # This is out of range.


other_peeps = []
other_peeps[3] = 'beebee Meaner'
other_peeps[0] = 'Ah-ha'
other_peeps[1] = 'Seedee'
other_peeps[0] = 'beebee Ah-ha'
puts other_peeps


languages = ['English', 'Norwegian', 'Ruby']
languages.each do |lang|
puts 'I love ' + lang + '!'
puts 'Don\'t you?'
end
puts 'And let\'s hear it for Java!'
puts '<crickets chirp in the distance>'

puts''
#Go-go-gadget-integer-method...
3.times do
puts 'Hip-Hip-Hooray!'
end

