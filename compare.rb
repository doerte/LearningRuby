# get list of citations from bib-tex file
fh = File.open("D:/Latex/diss.bib","r");
out = File.open("references.txt","w");

fh.each do |entry|
  if entry =~ /^@/
	out.puts entry	  
  end
end

fh.close
out.close


references = IO.readlines("references.txt")

references = references.each  do |ref|
ref.sub!(/@.*{/, "") 
ref.sub!(/,/,"")
end
	
out = File.open("references.txt", "w")
out.puts references.sort
out.close


# get list of pdf files from directory
article_dir = "D:/Texte/*.pdf"
articles = Dir[article_dir]
articles = articles.map do |entry|
  File.basename(entry, ".pdf")
end

out = File.open("D:/Texte/articles.txt", "w")
out.puts articles.sort
out.close


#get list of copied articles
copies = IO.readlines("books.txt") + IO.readlines("mapA.txt") + IO.readlines("mapB.txt")

#compare the lists
pdfs = IO.readlines("articles.txt")
cites = IO.readlines("references.txt")

extra_pdfs = pdfs - cites

extra_cites = cites - pdfs -copies

extra_copies = copies - cites

if extra_pdfs.length  > 0
out = File.open("D:/Texte/extraPDF.txt", "w")
out.puts extra_pdfs.sort
end

if extra_cites.length > 0
out2 = File.open("D:/Texte/extraCITE.txt", "w")
out2.puts extra_cites.sort
end

if extra_copies.length > 0
out3 = File.open("D:/Texte/extraCOPIES.txt", "w")
out3.puts extra_copies.sort
end

puts "Amount of pdfs: " + pdfs.length.to_s
puts "Amount of copies: " +copies.length.to_s
puts "Amount of citations: " + cites.length.to_s
puts "Extra pdfs: " +extra_pdfs.length.to_s
puts "Extra citations: " +extra_cites.length.to_s
puts "Extra copies: " + extra_copies.length.to_s