title = [['Getting Started', 1],['Numbers', 9],['Letters', 13]]


puts 'Table of Contents'.center(50)
puts ''

chapterNum =1
title.each do |table|
  tabtit = table[0]
  tabpage = table[1]  
  
 beginning =  'Chapter ' + chapterNum.to_s + ': ' + tabtit.to_s 
 ending = 'page ' + tabpage.to_s

  puts beginning.ljust(30) + ending.rjust(20)
  
  
  chapterNum = chapterNum + 1
end





