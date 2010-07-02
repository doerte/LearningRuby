# Ask for directory to store pictures
puts 'Please enter the directory you would like to save the pictures and videos to.'
save_loc = gets.chomp

# Find pictures to be moved
puts 'What is the current path to the pictures/videos?'
orig_loc = gets.chomp
pic_loc = orig_loc + '/*.{JPG,jpg}'
vid_loc = orig_loc + '/*.{avi,AVI}'
pic_names = Dir[pic_loc]
vid_names = Dir[vid_loc]

puts 'What would you like to call this batch?'
batch_name = gets.chomp

# Make a new folder with the batch name and change working directory to it!
Dir.chdir(save_loc)
Dir.mkdir(batch_name)
save_loc = save_loc + '/' + batch_name
Dir.chdir(save_loc)

puts
print "Downloading #{pic_names.length} #{+} #{vid_names.length} files, #{pic_names.length} pictures and #{vid_names.length} videos!"

def padIt(max, number)
  zeros = Math::log10(max).to_i - Math::log10(number).to_i
  zerosStr = "0" * zeros
  "#{zerosStr}#{number}"
end

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

puts 'All pictures have been moved, now the videos'

Dir.mkdir(Videos)
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
end
puts # This is so we aren't on progress bar line.
puts 'Finished moving/renaming the files'