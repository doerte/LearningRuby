output = []
buffer = []
reg = /^[^Mk]/
regM = /^Mk([0-9]+)=[^Stimulus]/
reg1 = /^Mk([0-9]+)=Stimulus,(S  1),([0-9]+),0,0/
reg2 = /^Mk([0-9]+)=Stimulus,(S  2|S  3|S  4),([0-9]+),0,0/
reg3 = /^Mk([0-9]+)=Stimulus,(S.*),([0-9]+),0,0/

input = IO.readlines("15_1_AV.vmrk") 



input.map {|line|
	
	if line =~ reg || line =~ regM
		output.push line
	
	elsif line =~ reg1
		buffer[0] = line
		
	elsif line =~ reg2
		output.push buffer.to_s
		output.push line
	
	elsif line =~ reg3
		output.push line
		
	end
}


out = File.open("test.vmrk","w")
out.puts output
out.close



