# Ask for directory to store pictures
puts 'Please enter the directory you would like to save the pictures to.'
save_loc = gets.chomp

# Find pictures to be moved
puts 'What is the current path to the pictures?'
orig_loc = gets.chomp
orig_loc = orig_loc + '/*.{JPG,jpg}'
pic_names = Dir[orig_loc]

puts 'What would you like to call this batch?'
batch_name = gets.chomp

# Make a new folder with the batch name and change working directory to it!
Dir.chdir(save_loc)
Dir.mkdir(batch_name)
save_loc = save_loc + '/' + batch_name
Dir.chdir(save_loc)

puts
print "Downloading #{pic_names.length} files: "

def padIt(max, number)
  zeros = Math::log10(max).to_i - Math::log10(number).to_i
  zerosStr = "0" * zeros
  "#{zerosStr}#{number}"
end

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
puts # This is so we aren't on progress bar line.
puts 'Finished moving/renaming the files'