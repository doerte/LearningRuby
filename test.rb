array = IO.read("d:/latex/diss.bib")
string = array.to_s
array2 = string.split("@")

array3 =[]
array2.each {|x| 
hash = Hash["file",x] 
array3.push hash
}

puts array3