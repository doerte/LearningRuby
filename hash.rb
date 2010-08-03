###################### 
#Program to reorganize ERP-Trigger #
######################
require 'fileutils'

reg = /^[^Mk]/
regM = /^Mk([0-9]+)=[^Stimulus]/
reg1 = /^Mk([0-9]+)=Stimulus,(S  1),([0-9]+),0,0/
reg2 = /^Mk([0-9]+)=Stimulus,(S  2|S  3|S  4),([0-9]+),0,0/
reg3 = /^Mk([0-9]+)=Stimulus,(S[^,]*),([0-9]+),0,0/
markerID = 0

def addMarker f, m, mrk, t 
	out = File.open(f,"a")
	out.puts "Mk#{m}=Stimulus,#{mrk},#{t},0,0" 
	out.close
end




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

	out = File.open(file.to_s,"w")
	out.puts output
	out.close
	
	
	

#new stuff
	output.flatten!
	
	# use sort-functie (write own compare) to sort array properly so last marker ID can be determined	
	out2 = output.sort {|a,b|
		markerA = a.split('=')[0].gsub('Mk', '')
		markerB = b.split('=')[0].gsub('Mk', '')
		markerA.to_i <=> markerB.to_i
	}
	
	out = File.open("#{file}blub.txt","w")
	out.puts out2
	out.close
	
	

#####
# To do: fix VO problem, get last MarkerID to add up to...
#####
	output.each {|line|
		if line =~ reg3
			info = reg3.match(line)
			markerID = info[1].to_i + 1
		end
	}
	
	

	if file =~ /(AV|VO)/
		output.each {|line|
			if line =~ reg3
				info = reg3.match(line)
				time = info[3].to_i + 110
				timeVis = info[3].to_i + 60
				if info[2] == "S  1"
					addMarker file.to_s, markerID, "Std_vis", timeVis.to_s
					markerID = markerID +1
					addMarker file.to_s, markerID, "Std_aud", time.to_s
					markerID = markerID +1
				elsif info[2] == "S  2"
					addMarker file.to_s, markerID, "Dev1_vis", timeVis.to_s
					markerID = markerID +1
					addMarker file.to_s, markerID, "Dev1_aud", time.to_s
					markerID = markerID +1
				elsif info[2] == "S  3"
					addMarker file.to_s, markerID, "Dev2_vis", timeVis.to_s
					markerID = markerID +1
					addMarker file.to_s, markerID, "Dev2_aud", time.to_s
					markerID = markerID +1	
				elsif info[2] == "S  4"
					addMarker file.to_s, markerID, "McG_vis", timeVis.to_s
					markerID = markerID +1
					addMarker file.to_s, markerID, "McG_aud", time.to_s
					markerID = markerID +1
				end	
		
			end
		}
		
	else output.each {|line|
			if line =~ reg3
				info = reg3.match(line)
				time = info[3].to_i + 110
			
				if info[2] == "S  1"
					addMarker file.to_s, markerID, "Std_aud", time.to_s
					markerID = markerID +1
				elsif info[2] == "S  2"
					addMarker file.to_s, markerID, "Dev1_aud", time.to_s
					markerID = markerID +1				
				elsif info[2] == "S  3"
					addMarker file.to_s, markerID, "Dev2_aud", time.to_s
					markerID = markerID +1				
				elsif info[2] == "S  4"
					addMarker file.to_s, markerID, "McG_aud", time.to_s
					markerID = markerID +1
				end	
			
			end
		}
	end


	Dir.chdir("..")
}