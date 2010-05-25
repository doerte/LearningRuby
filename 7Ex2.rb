puts 'HI MY DEAR, HOW NICE YOU COME TO VISIT ME! WHAT\'S UP?'
bye_count = 0

while true
  answer = gets.chomp
  if answer == 'BYE'
    bye_count = bye_count +1
  else 
    bye_count = 0
  end
  
  if bye_count >= 3
    puts 'BYE, MY DEAR'
    break
  end
  
  if answer != answer.upcase
    puts 'HUH?! SPEAK UP, SONNY!'
  else 
    year =  1930 + rand(21)
    puts 'NO, NOT SINCE ' + year.to_s + '!'
   
  end
end
