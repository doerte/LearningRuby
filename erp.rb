###################### 
#Program to reorganize ERP-Trigger #
######################
require 'fileutils'

reg = /^Mk([0-9]+)=Stimulus,(S\s*[0-9]+),([0-9]+),0,0.*$/

def addMarker f, m, mrk, t 
	out = File.open(f,"a")
	out.puts "Mk#{m}=Stimulus,#{mrk},#{t},0,0" 
	out.close
end

def selectMarker f
	lines = IO.readlines(f)
	if lines.last == "\n"
		puts "It's empty"
	else entry = lines.last
		output = entry.gsub("Std_aud","Std_aud1")
		output = output.gsub("Std_vis","Std_vis1")
		out = File.open(f,"a")
		out.puts output
		out.close
	end
end

##### get files to process ######
files = Dir["*.vmrk"]

files.each {|file|
	print "."
	#copy marker files in new directory and switch to it
	unless File.directory?("NewMarkers") 
		Dir.mkdir("NewMarkers")
	end
	FileUtils.copy(file.to_s, "NewMarkers/#{file.to_s}")
	
	Dir.chdir("NewMarkers")
	markerID = String.new	
	
	#edit marker files in new directory
	input = IO.readlines(file.to_s)
	
	
	
	input.each {|line|
		if line =~ reg
			p line
			info = reg.match(line)
			markerID = info[1].to_i + 1
		end
	}
	
	

	if file =~ /(AV|VO)/
		input.each {|line|
			if line =~ reg
				info = reg.match(line)
				time = info[3].to_i + 110
				timeVis = info[3].to_i + 60
				if info[2] == "S  1"
					addMarker file.to_s, markerID, "Std_vis", timeVis.to_s
					markerID = markerID +1
					addMarker file.to_s, markerID, "Std_aud", time.to_s
					markerID = markerID +1
				elsif info[2] == "S  2"
					#selectMarker file
					addMarker file.to_s, markerID, "Dev1_vis", timeVis.to_s
					markerID = markerID +1
					addMarker file.to_s, markerID, "Dev1_aud", time.to_s
					markerID = markerID +1
				elsif info[2] == "S  3"
					#selectMarker file
					addMarker file.to_s, markerID, "Dev2_vis", timeVis.to_s
					markerID = markerID +1
					addMarker file.to_s, markerID, "Dev2_aud", time.to_s
					markerID = markerID +1	
				elsif info[2] == "S  4"
					#selectMarker file
					addMarker file.to_s, markerID, "McG_vis", timeVis.to_s
					markerID = markerID +1
					addMarker file.to_s, markerID, "McG_aud", time.to_s
					markerID = markerID +1
				end	
			
			end
		}
		
	else input.each {|line|
			if line =~ reg
				info = reg.match(line)
				time = info[3].to_i + 110
			
				if info[2] == "S  1"
					addMarker file.to_s, markerID, "Std_aud", time.to_s
					markerID = markerID +1
				elsif info[2] == "S  2"
					#selectMarker file
					addMarker file.to_s, markerID, "Dev1_aud", time.to_s
					markerID = markerID +1				
				elsif info[2] == "S  3"
					#selectMarker file
					addMarker file.to_s, markerID, "Dev2_aud", time.to_s
					markerID = markerID +1				
				elsif info[2] == "S  4"
					#selectMarker file
					addMarker file.to_s, markerID, "McG_aud", time.to_s
					markerID = markerID +1
				end	
			
			end
		}
	end
	

	#switch back to parent directory
	Dir.chdir("..")
}	


	
	
