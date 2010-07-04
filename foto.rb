# Find pictures to be moved
puts 'What is the current path to the pictures/videos? If it\'s on drive "F:/" you can just hit enter to proceed'
orig_loc = gets.chomp

# Search F:/ for files
if orig_loc == ''
	orig_loc = 'F:/**'
end

pic_loc = orig_loc + '/*.jpg'.downcase
vid_loc = orig_loc + '/*.avi'.downcase
pic_names = Dir[pic_loc]
vid_names = Dir[vid_loc]
thm_names = Dir[orig_loc + '/*.{thm}'.downcase]

# Ask for directory to store pictures
puts 'Please enter the directory you would like to save the pictures and videos to. If you want to save to this years folder on D:/Fotos you can just hit enter!'
save_loc = gets.chomp

# Change to default save-location
if save_loc == ''
	Dir.chdir('D:/Fotos')
	t = Time.now
	year = t.year
	path = "D:/Fotos/#{year}"
	
	if File.exists?(path) && File.directory?(path)
			
	else	Dir.mkdir(year.to_s)
		
	end
	
	save_loc = 'D:/Fotos/' + year.to_s
	Dir.chdir(save_loc)
end

puts 'What would you like to call this batch?'

#batch_name = batch_name

batch_name = nil
while true
	batch_name = gets.chomp
	if File.exists?(batch_name) && File.directory?(batch_name)
		puts 'This batch name exists already - please choose another one'
	else
		break
	end
end

# Check whether dir exists and if not make a new folder with the batch name and change working directory to it, otherwise ask for new batch name!
#def batch input
#	batch_name = gets.chomp
#	if File.exists?(batch_name) && File.directory?(batch_name)
#		puts 'This batch name exist already - please choose another one'
#		
#		return batch batch_name
#	else return batch
#	end
#end

#batch batch_name

Dir.mkdir(batch_name)
save_loc = save_loc + '/' + batch_name
Dir.chdir(save_loc)
	
puts
print "Downloading #{pic_names.length + vid_names.length} files, #{pic_names.length} pictures and #{vid_names.length} videos!"

def padIt(max, number)
  zeros = Math::log10(max).to_i - Math::log10(number).to_i
  zerosStr = "0" * zeros
  "#{zerosStr}#{number}"
end

puts
puts 'First all pictures will be moved'
# This will be our counter, starting at 1
pic_number = 1
	pic_names.each do |name|
		print '.' # This is our "progress bar".

		new_name = "#{batch_name}" + padIt(pic_names.length, pic_number)

		save_name = new_name + ".jpg"
	
		while File.exist? save_name
			new_name = new_name + "a"
			save_name = new_name + ".jpg"
		end

		File.rename(name, save_name)
		# Finally, we increment the counter.
		pic_number = pic_number + 1
	end	




if vid_names.length >= 1
	puts
	puts 'All pictures have been moved, now the videos'
	Dir.mkdir('Videos')
	save_loc = save_loc + '/Videos'
	Dir.chdir(save_loc)

	vid_number = 1
	vid_names.each do |name|
		print '.' # This is our "progress bar".

		new_name = "#{batch_name}" + padIt(vid_names.length, vid_number)
		save_name = new_name + ".avi"
	
		while File.exist? save_name
			new_name = new_name + "a"
			save_name = new_name + ".avi"
		end

		File.rename(name, save_name)
		# Finally, we increment the counter.
		vid_number = vid_number + 1

	end
else
	puts
	puts 'All pictures have been moved!'
end

#removing thumbnails
puts
puts "Deleting #{thm_names.length} thumbnails"
thm_names.each do |name| 
		print '.'
	File.delete(name)
end

puts # This is so we aren't on progress bar line.
puts 'Finished moving/renaming the files'