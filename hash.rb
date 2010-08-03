###################### 
#Program to reorganize ERP-Trigger #
######################
require 'fileutils'

reg = /^[^Mk]/
regM = /^Mk([0-9]+)=[^Stimulus]/
reg1 = /^Mk([0-9]+)=Stimulus,(S  1),([0-9]+),0,0/
reg2 = /^Mk([0-9]+)=Stimulus,(S  2|S  3|S  4),([0-9]+),0,0/
reg3 = /^Mk([0-9]+)=Stimulus,(S.*),([0-9]+),0,0/




##### get files to process ######
files = Dir["*.vmrk"]

files.each {|file|
	print "."
	array = []
	buffer=[]
	output=[]
	finalarray=[]
	#copy marker files in new directory and switch to it
	unless File.directory?("NewMarkers") 
		Dir.mkdir("NewMarkers")
	end
	FileUtils.copy(file.to_s, "NewMarkers/#{file.to_s}")
	
	Dir.chdir("NewMarkers")
	#markerID = String.new	
	
	#edit marker files in new directory
	array = IO.readlines(file.to_s)
	

	# header stuff to output and delete from array
	array.each {|entry|
		if entry =~ reg || entry =~ regM
			output.push entry
		end
	}
	p output
	array.delete_if {|x| x =~ reg || x =~ regM}

	# make triplets of triggers in big array
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
	

	# reverse array
	finalarray.reverse!
	finalarray


	#keep only triplets of triggers S2,S3 and S4 as well as S1 if preceded by deviant!
	finalarray.each {|a|
		if a[0] =~ reg2 
			output.push a
		elsif a[0] =~ reg1 && buffer[0]=~reg2
			output.push a
		end
		buffer[0] = a[0]
	}


	#write to file
	out = File.open(file.to_s,"w")
	out.puts output
	out.close
	Dir.chdir("..")
}