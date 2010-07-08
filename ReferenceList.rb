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

