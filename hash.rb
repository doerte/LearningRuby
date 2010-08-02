reg = /^[^Mk]/
regM = /^Mk([0-9]+)=[^Stimulus]/
reg1 = /^Mk([0-9]+)=Stimulus,(S  1),([0-9]+),0,0/
reg2 = /^Mk([0-9]+)=Stimulus,(S  2|S  3|S  4),([0-9]+),0,0/
reg3 = /^Mk([0-9]+)=Stimulus,(S.*),([0-9]+),0,0/


array = []
buffer=[]
output=[]
hash = {}
bla =[]
blub =[]
blob =[]
blub2 = []

File.foreach("15_1_AV.vmrk") {|line|
	array.push line
}
	

# header stuff to output and delete from array
array.each {|entry|
	if entry =~ reg || entry =~ regM
		output.push entry
	end
}

array.delete_if {|x| x =~ reg || x =~ regM}

# get only entries denoting stimulus type in bla, rest in blub
array.each {|entry|
	
	if array.index == 0 || array.index(entry)%3 == 0
		bla.push entry 
	else
		blub.push entry 
	end
	
}

# split blub into blob and blub2 containing triggers for answer and videoquality
blub.each {|entry|
	if blub.index == 0 || blub.index(entry)%2 == 0
		blob.push entry
	else blub2.push entry
	end
}

p blub2

if bla.length != blub2.length()
puts "error in bla blub blob" 
Process.exit
elsif
bla.length != blob.length
puts "error in bla blub blob" 
Process.exit
elsif
blub2.length != blob.length
puts "error in bla blub blob" 
Process.exit
end

# put triggers into hash with stimulus => [answer, vidqual] 
while bla.length > 0 do 

	hash[bla[0]]= {blob[0],blub2[0]}
	bla.delete_at(0)
	bla
	blob.delete_at(0)
	blob
	blub2.delete_at(0)

end



#array.map {|entry|

	#entry.each_pair {|k, v|
	#if k== "S  1"
	#	buffer = []
	#	buffer.push k
	#	buffer.push v[0]
	#	buffer.push v[1]
		
	#else
	#	output = buffer
	#	output.push k
	#	output.push v[0]
	#	output.push v[1]
		
	#end
	
#}


out = File.open("text.txt","w")
out.puts hash
out.close