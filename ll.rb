output = []
buffer =[]
reg1 = /^Mk([0-9]+)=Stimulus,(Std.*),([0-9]+),0,0$/
reg2 = /^Mk([0-9]+)=Stimulus,([^S].*),([0-9]+),0,0$/

input = IO.readlines("1_1_AV.vmrk") {|line|
	if line =~ reg1
		buffer[0].push line
	elsif line =~ reg2
		output.push buffer.to_s
		output.push line
		p output
	end
}


out = File.open("test.vmrk","w")
out.puts output
out.close



