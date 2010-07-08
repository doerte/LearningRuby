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

references = ['references.txt']

references.each do |ref|
  text = File.read(ref)
  out = File.open('D:/Texte/references.txt', "w")
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
  end

pdfs = IO.readlines("articles.txt")
cites = IO.readlines("references.txt")

extra_pdfs = pdfs - cites
extra_cites = cites - pdfs

out = File.open('D:/Texte/extraPDF.txt', "w")
out.puts extra_pdfs

out2 = File.open('D:/Texte/extraCITE.txt', "w")
out2.puts extra_cites

puts 'Amount of pdfs: ' pdfs.length
puts 'Amount of citations: ' cites.length
puts 'Extra pdfs: 'extra_pdfs.length
puts 'Extra citations: 'extra_cites.length