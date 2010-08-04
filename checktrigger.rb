files = Dir["*.vmrk"]
files.each {|file|
	print "."
	array = []
	buffer=[]
	output=[]
	finalarray=[]
	
	array = IO.readlines(file.to_s)
	array.delete_if {|x| x =~ /^[^Mk]/ || x =~ /^Mk([0-9]+)=[^Stimulus]/}
	
	while array.length > 0 do
		buffer[0] = array[0]
		buffer[1] = array[1]
		buffer[2] = array[2]
		finalarray.push buffer
				
		buffer = []
		array.delete_at(0)
		array.delete_at(0)
		array.delete_at(0)
	end
	
	unless finalarray.last[0] =~ /^[Mk]/ &&  finalarray.last[1] =~ /^[Mk]/   && finalarray.last[2] =~ /^[Mk]/
		
		puts "#{file} has a problem"
		out = File.open("#{file}.txt","w")		
		out.puts finalarray.inspect
		out.close
	end
	
}