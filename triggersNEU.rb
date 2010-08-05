###################### 
#Program to reorganize ERP-Trigger #
######################
require 'fileutils' #to allow for copying files

# some regular expressions used later on
reg = /^[^Mk]/ #everything that's not starting with Mk, so the header!
regM = /^Mk([0-9]+)=[^Stimulus]/ #Markers that are not of type "stimulus"
reg1 = /^Mk([0-9]+)=Stimulus,(S  1),([0-9]+),0,0/ #Marker of standards
reg2 = /^Mk([0-9]+)=Stimulus,(S  2|S  3|S  4),([0-9]+),0,0/ #markers of deviants
reg3 = /^Mk([0-9]+)=Stimulus,(S[^,]*),([0-9]+),0,0/ #all stimulus markers

# some variables used later on
markerID = 0
problems = []

# addMarker method to add markers based on existing markers
def addMarker f, m, mrk, t 
	out = File.open(f,"a")
	out.puts "Mk#{m}=Stimulus,#{mrk},#{t},0,0" 
	out.close
end

##### get files to process ######
files = Dir["*.vmrk"]

#### check files on data structure #####
puts "Checking files on data structure!"
x = files.length.to_f/10
y = files.length.to_f/10


files.each {|file|
	
	if files.length <= 10
		
		puts "#{((files.index(file)+1)/files.length.to_f*100).to_i} %"
		
	elsif file == files.last
		puts "100%"
	else
		if file == files[x]
			puts "#{((files.index(file)+1)/files.length.to_f*100).to_i} %"
			x = x+y
		end
	end
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
		
		problems.push file
		puts "#{file} has a problem"
		out = File.open("#{file}.txt","w")		
		out.puts finalarray.inspect
		out.close
	end
	
}

puts ""
if problems.length > 0
	puts "You have problems to fix, see filenames above!"
	Process.exit
else puts "Done! Processing Files:"
end

x = files.length.to_f/10
y = files.length.to_f/10
### Process files ##########
files.each {|file|
	
	if files.length <= 10
		
		puts "#{((files.index(file)+1)/files.length.to_f*100).to_i} %"
		
	elsif file == files.last
		puts "100%"
	else
		if file == files[x]
			puts "#{((files.index(file)+1)/files.length.to_f*100).to_i} %"
			x = x+y
		end
	end
	
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
	
	#keep only triplets of triggers S2,S3 and S4 as well as S1 if preceded by deviant!
	finalarray.each {|a|
		if a[0] =~ reg2 
			output.push a
		elsif a[0] =~ reg1 && buffer[0]=~reg2
			output.push a
		end
		buffer[0] = a[0]
	}
	
	# use sort-functie to sort array properly so last marker ID can be determined	
	output.flatten!
	output = output.sort {|a,b|
		markerA = a.split('=')[0].gsub('Mk', '')
		markerB = b.split('=')[0].gsub('Mk', '')
		markerA.to_i <=> markerB.to_i
	}

	# write reduced amount of triggers (sorted) to file
	out = File.open(file.to_s,"w")
	out.puts output
	out.close
	
	
#####
#get last MarkerID to add up to...
#####
	
	if output.last =~ reg3
			info = reg3.match(output.last)
			markerID = info[1].to_i + 1
	end	
	
	
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

puts ""
puts "Done!"