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
  out.close
  end

# get list of pdf files from directory
article_dir = 'D:/Texte/*.pdf'

articles = Dir[article_dir]

def nopath(filenames)
	articles_and_paths = filenames.map do |s|
		[s, s.split('/')] # [file, path]
	end
end


list = nopath(articles)

out = File.open("articlesA.txt","w")
out.puts list
out.close

fh = File.open("articlesA.txt","r");
out = File.open("articlesB.txt","w");
fh.each { |line|
	out.puts line unless line =~ /D:/
}
fh.close
out.close

fh = File.open("articlesB.txt","r");
out = File.open("articlesC.txt","w");
fh.each { |line|
	out.puts line unless line =~ /Texte/
}
fh.close
out.close


file_names = ['articlesC.txt']

file_names.each do |file_name|
  text = File.read(file_name)
  out = File.open('D:/Texte/articles.txt', "w")
  out.puts text.gsub(/.pdf/, "")
  out.close
  
end


File.delete('articlesA.txt')
File.delete('articlesB.txt')
File.delete('articlesC.txt')


#compare both lists
pdfs = IO.readlines("articles.txt")
cites = IO.readlines("references.txt")

extra_pdfs = pdfs - cites
extra_cites = cites - pdfs

out = File.open('D:/Texte/extraPDF.txt', "w")
out.puts extra_pdfs

out2 = File.open('D:/Texte/extraCITE.txt', "w")
out2.puts extra_cites

puts 'Amount of pdfs: ' + pdfs.length.to_s
puts 'Amount of citations: ' + cites.length.to_s
puts 'Extra pdfs: '+extra_pdfs.length.to_s
puts 'Extra citations: '+extra_cites.length.to_s