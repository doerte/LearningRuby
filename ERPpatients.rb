#!/usr/bin/env ruby -wKU

##### Check Arguments #######
if ARGV.length != 1
	puts "You need to provide an argument, please enter path to the files you want to convert!"
	Process.exit
else
	puts "You're converting all files in #{ARGV[0]}"
end

#define sum and mean for array
require 'csv'

class Array 
  def sum
    inject(0) {|sum,x| sum+x} 
  end

  def mean
    sum.to_f / size 
  end
end

#method to write data from hash to csv file per time interval
def writetocsv cue
  File.open($dir+"/"+cue+".csv","w"){|file|
    $times.each_pair {|key,value|
      if key =~ /_#{cue}/
        $output.push(value)
      end
    }

    size = $output.length/18

    while $output.length > 0 do
      size.times do
        $write.push($output[0])
        $output.delete_at(0)
      end
      file.print $write.join(",")
      file.puts
      $write = []
    end 
  }  
end



#Get file and change decimal indicator, add commas
dir = ARGV[0] + "/*.dat"
files = Dir[dir]

files.each {|file|
  
  f = File.read(file).gsub(",",".").gsub(" ",",")
  
  $dir = file.gsub!("_good.dat","")
  unless File.directory?($dir) 
    Dir.mkdir($dir)
  end
 
  
  

#parse file into array and transpose
  input = CSV.parse(f)
  trans = input.transpose

  electrodes=[]
  buffer = []

#convert to floats
  trans.each {|array|
    buffer.push(array[0])
    array.shift
    array.each{|string|
      buffer.push(string.to_f)
    }
    electrodes.push(buffer)
    buffer = []
  }


  #save in hash (array of all time points per stimulus per electrode)
  hash = {}

  electrodes.each {|elec|
    count = 1
    i = 0
    ident = elec[0]
    elec.shift
    while i+299 < elec.length 
      array = elec[i..i+299]
      hash["#{ident}_stim_#{count}"]=array
      count = count + 1
      i = i + 300
    end
  }

#time intervals with 1 value per interval per stimulus per electrode
  $times = {}
  hash.each_pair {|key, value|
    $times["#{key}_BL"] = value[0..49].mean.round(5)
    $times["#{key}_0-40"] = value[50..59].mean.round(5)
    $times["#{key}_40-80"] = value[60..69].mean.round(5)
    $times["#{key}_80-120"] = value[70..79].mean.round(5)
    $times["#{key}_120-160"] = value[80..89].mean.round(5)
    $times["#{key}_160-200"] = value[90..99].mean.round(5)
    $times["#{key}_200-240"] = value[100..109].mean.round(5)
    $times["#{key}_240-280"] = value[110..119].mean.round(5)
    $times["#{key}_280-320"] = value[120..129].mean.round(5)
    $times["#{key}_320-360"] = value[130..139].mean.round(5)
    $times["#{key}_360-400"] = value[140..149].mean.round(5)
    $times["#{key}_400-440"] = value[150..159].mean.round(5)
    $times["#{key}_440-480"] = value[160..169].mean.round(5)
    $times["#{key}_480-520"] = value[170..179].mean.round(5)
    $times["#{key}_520-560"] = value[180..189].mean.round(5)
    $times["#{key}_560-600"] = value[190..199].mean.round(5)  
  }

#write csv files
  $output = []
  $write = []

  writetocsv "BL"
  writetocsv "0-40"
  writetocsv "40-80"
  writetocsv "80-120"
  writetocsv "120-160"
  writetocsv "160-200"
  writetocsv "200-240"
  writetocsv "240-280"
  writetocsv "280-320"
  writetocsv "320-360"
  writetocsv "360-400"
  writetocsv "400-440"
  writetocsv "440-480"
  writetocsv "480-520"
  writetocsv "520-560"
  writetocsv "560-600"
}
