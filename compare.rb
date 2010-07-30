if ARGV.length != 2
	puts "You need to provide 2 arguments, please enter path to the bib-file and folder containing the pdfs as arguments!"
	Process.exit
else
	puts "Your bib-file is: #{ARGV[0]} and your pdfs are located in the follwoing directory #{ARGV[1]}"
end


###### Get list of citations from bib-tex file #######

#get array with identifiers (complete line including identifier)
input = IO.readlines(ARGV[0])
ident = []
input.each {|entry|
	if entry =~ /^@/
		ident.push entry.strip
	end
}

#clean up array to leave only identifiers
ident = ident.each  {|ref|
	ref.sub!(/@.*{/, "") 
	ref.sub!(/,/,"")
	ref.strip!
}

#write to file	
out = File.open("references.txt", "w")
out.puts ident.sort
out.close


###### Get list of pdf files from directory  and save to file########
pdf_dir = ARGV[1]+ "/*.pdf"
pdfs = Dir[pdf_dir]
pdfs = pdfs.map {|entry|
	File.basename(entry, ".pdf")
}

out = File.open("pdfs.txt", "w")
out.puts pdfs.sort
out.close


###### Generate overview of copies from diss.bib ##############

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
		elsif entry =~ /^.*mapD/
			files.push "mapD"
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

#check bib-file!
if ident.length > files.length
	puts "You have more identifiers than file-tags"
	puts "This program will stop now, go check your bib-file"
	Process.exit
elsif ident.length < files.length
	puts "You have more file-tags than identifiers"
	puts "This program will stop now, go check your bib-file"
	Process.exit
end

puts "You passed the test... same amount of identifiers and file-tags! The program will proceed!"

#combine arrays to new array with pairs
combine = ident.zip(files)

#delete arrays with no text-file
mapA = []
mapB = []
mapC = []
mapD = []
books = []

while combine.length > 0
	file_pair = combine.pop
	if file_pair.include?("mapA")
		mapA.push file_pair
	elsif 	file_pair.include?("mapB")
		mapB.push file_pair
	elsif 	file_pair.include?("mapC")
		mapC.push file_pair
	elsif 	file_pair.include?("mapD")
		mapD.push file_pair
	elsif 	file_pair.include?("books")
		books.push file_pair
	end
end		

#clean up within arrays
mapA = mapA.flatten.sort
mapB = mapB.flatten.sort
mapC = mapC.flatten.sort
mapD = mapD.flatten.sort
books = books.flatten.sort

mapA.delete("mapA") 
mapB.delete("mapB")
mapC.delete("mapC")
mapD.delete("mapD")
books.delete("books")

# write arrays to files
outA = File.open("mapA.txt","w")
outB = File.open("mapB.txt","w")
outC = File.open("mapC.txt","w")
outD = File.open("mapD.txt","w")
outBook = File.open("books.txt","w")

outA.puts mapA
outB.puts mapB
outC.puts mapC
outD.puts mapD
outBook.puts books

outA.close
outB.close
outC.close
outD.close
outBook.close


###### Getting everything together to compare #########

#get array of all copied articles
copies = mapA + mapB + mapC+ mapD + books

#compare the lists
extra_pdfs = pdfs - ident
extra_cites = ident - pdfs - copies
pdf_prints = pdfs & copies

if extra_pdfs.length  > 0
	out = File.open("extraPDF.txt", "w")
	out.puts extra_pdfs.sort
	out.close
end

if extra_cites.length > 0
	out = File.open("extraCITE.txt", "w")
	out.puts extra_cites.sort
	out.close
end

if pdf_prints.length > 0
	out = File.open("pdfprints.txt", "w")
	out.puts pdf_prints.sort
	out.close
end

puts "Amount of pdfs: " + pdfs.length.to_s
puts "Amount of copies: " +copies.length.to_s
puts "Amount of citations: " + ident.length.to_s
puts "Pdfs not cited: " + extra_pdfs.length.to_s
puts "Citations without text: " + extra_cites.length.to_s
puts "Prints also pdf: " + pdf_prints.length.to_s
