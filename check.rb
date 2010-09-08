ARGV.each do|a|
   puts "Argument: #{a}"
 end


if ARGV.length != 2
	puts "You need to provide 2 arguments, please enter path to the bib-file and folder containing the pdfs as arguments!"
	Process.exit
else
	puts "Your bib-file is: #{ARGV[0]} and your pdfs are located in the follwoing directory #{ARGV[1]}"
end


#get array with identifiers (complete line including identifier)
input = IO.readlines(ARGV[0])
ident = []
input.each {|entry|
	if entry =~ /^@/
		ident.push entry.strip
	end
}

#get array with file information
input = IO.readlines (ARGV[0])
	
files = []
input.each {|entry|
	entry.strip!
	if entry =~ /^\s*file/
		if entry =~ /^.*mapA/
			files.push "mapA"
		elsif entry =~ /^.*mapB/
			files.push "mapB"
		elsif entry =~ /^.*mapC/
			files.push "mapC"
		elsif entry =~ /^.*books/
			files.push "books"
		else
			files.push "0"
		end
	elsif entry =~/^\s*bla/
		if entry =~ /^.*blank/ 
			files.push "0"
		end
	end
}

#check bib-tex
if ident.length > files.length
	puts "You have more identifiers than file-tags"
	puts "This program will stop now, go check your bib-file"
	Process.exit
elsif ident.length < files.length
	puts "You have more file-tags than identifiers"
	puts "This program will stop now, go check your bib-file"
	Process.exit
end

puts "You passed the test... same amount of identifiers and file-tags!"
	
	


