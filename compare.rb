# get list of citations from bib-tex file
fh = File.open("D:/Latex/diss.bib","r");
out = File.open("references.txt","w");
fh.each { |line|
	if line =~/@A/
		out.puts line
	elsif line =~/@I/
		out.puts line
	elsif line =~/@B/
		out.puts line
	elsif line =~/@M/
		out.puts line
	elsif line =~/@P/
		out.puts line
	elsif line =~/@C/
		out.puts line
	end}
fh.close
out.close

references = ["references.txt"]

references.each do |ref|
  text = File.read(ref)
  out = File.open("D:/Texte/references.txt", "w")
  text = text.gsub(/@ARTICLE{/, "")
  text = text.gsub(/@INCOLLECTION{/, "")
  text = text.gsub(/@BOOK{/, "")
  text = text.gsub(/@INBOOK{/, "")
  text = text.gsub(/@INPROCEEDINGS{/, "")  
  text = text.gsub(/@MISC{/, "")
  text = text.gsub(/@MASTERSTHESIS{/, "")  
  text = text.gsub(/@PHDTHESIS{/, "")  
  text = text.gsub(/@CONFERENCE{/, "")
  text = text.gsub(/,/,"")
  out.puts text
  out.close
end


# get list of pdf files from directory
article_dir = "D:/Texte/*.pdf"
articles = Dir[article_dir]
articles = articles.sort
articles = articles.map do |entry|
  File.basename(entry, ".pdf")
end

out = File.open("D:/Texte/articles.txt", "w")
out.puts articles
out.close


#get list of copied articles
copies = IO.readlines("books.txt") + IO.readlines("mapA.txt") + IO.readlines("mapB.txt")

#compare the lists
pdfs = IO.readlines("articles.txt")
cites = IO.readlines("references.txt")



extra_pdfs = pdfs - cites
extra_pdfs = extra_pdfs.sort

extra_cites = cites - pdfs -copies
extra_cites = extra_cites.sort

extra_copies = copies - cites
extra_copies = extra_copies.sort

if extra_pdfs.length  > 0
out = File.open("D:/Texte/extraPDF.txt", "w")
out.puts extra_pdfs
end

if extra_cites.length > 0
out2 = File.open("D:/Texte/extraCITE.txt", "w")
out2.puts extra_cites
end

if extra_copies.length > 0
out3 = File.open("D:/Texte/extraCOPIES.txt", "w")
out3.puts extra_copies
end

puts "Amount of pdfs: " + pdfs.length.to_s
puts "Amount of copies: " +copies.length.to_s
puts "Amount of citations: " + cites.length.to_s
puts "Extra pdfs: " +extra_pdfs.length.to_s
puts "Extra citations: " +extra_cites.length.to_s
puts "Extra copies: " + extra_copies.length.to_s