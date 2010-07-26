###### Get list of citations from bib-tex file #######

#get array with identifiers (complete line including identifier)
input = IO.readlines("D:/Latex/diss.bib")
ident = []
input.each {|entry|
	if entry =~ /^@/
		ident.push entry
	end
}

#clean up array to leave only identifiers
ident = ident.each  {|ref|
	ref.sub!(/@.*{/, "") 
	ref.sub!(/,/,"")
}

#write to file	
out = File.open("references.txt", "w")
out.puts ident.sort
out.close


###### Get list of pdf files from directory  and save to file########
pdf_dir = "D:/Texte/*.pdf"
pdfs = Dir[pdf_dir]
pdfs = pdfs.map {|entry|
	File.basename(entry, ".pdf")
}

out = File.open("pdfs.txt", "w")
out.puts pdfs.sort
out.close


###### Generate overview of copies from diss.bib ##############

#get array with file information
input = IO.readlines ("D:/Latex/diss.bib")
	
files = []
input.each {|entry|
	if entry =~ /^  file/
		if entry =~ /^.*mapA/
			files.push "mapA"
		elsif entry =~ /^.*mapB/
			files.push "mapB"
		elsif entry =~ /^.*books/
			files.push "books"
		else files.push "0"
		end
	elsif entry =~/^  bla/
		if entry =~ /^.*blank/ 
			files.push "0"
		end
	end
}

#combine arrays to new array with pairs
combine = ident.zip(files)

#delete arrays with no text-file
mapA = []
mapB = []
books = []

while combine.length > 0
	file_pair = combine.pop
	if file_pair.include?("mapA")
		mapA.push file_pair
	elsif 	file_pair.include?("mapB")
		mapB.push file_pair
	elsif 	file_pair.include?("books")
		books.push file_pair
	end
end		

#clean up within arrays
mapA = mapA.flatten!.sort
mapB = mapB.flatten!.sort
books = books.flatten!.sort

mapA.delete("mapA") 
mapB.delete("mapB")
books.delete("books")

# write arrays to files
outA = File.open("mapA.txt","w")
outB = File.open("mapB.txt","w")
outBook = File.open("books.txt","w")

outA.puts mapA
outB.puts mapB
outBook.puts books

outA.close
outB.close
outBook.close


###### Getting everything together to compare #########

#get array of all copied articles
copies = mapA + mapB + books

pdfs = IO.readlines ("pdfs.txt")
ident = IO.readlines("references.txt")

#compare the lists
extra_pdfs = pdfs - ident
extra_cites = ident - pdfs - copies

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

puts "Amount of pdfs: " + pdfs.length.to_s
puts "Amount of copies: " +copies.length.to_s
puts "Amount of citations: " + ident.length.to_s
puts "Extra pdfs: " +extra_pdfs.length.to_s
puts "Extra citations: " +extra_cites.length.to_s
