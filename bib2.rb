###########################################
# Program to get lists of and compare citations, pdfs and copies of articles#
###########################################

##### Check Arguments #######
if ARGV.length != 2
	puts "You need to provide 2 arguments, please enter path to the bib-file and folder containing pdfs!"
	Process.exit
else
	puts "Your bib-file is: #{ARGV[0]} and your pdfs are located in the follwoing directory: #{ARGV[1]}!"
end

##### Define some stuff needed later #######
keyVal ={}
identifiers ={}
bib = {}
ident = nil
reg = /^\s*@[a-zA-Z]+\{([^,]+),/
regEntry = /^\s*([^@]+)\s*=\s*\{([^\}]+).*$/

substitutions = [
	["\\\"O", "Oe"],
	["\\\"A", "Ae"],
	["\\\"U", "Ue"],
	["\\\"e", "e"],
	["\\\"i", "i"],
	["\\\"a", "ae"],
	["\\\"o", "oe"],
	["\\\"u", "ue"],
	["\\\&", "and"],
	["\\\'", ""],
	["\\\`", ""],
	["\\\~", ""]
]

def applySubstitutions(line)
	substitutions.each { |s|
		line.strip!
		line.gsub!(s[0], s[1])
	}
end

###### Make hash of hashes from bibtex file #####

File.foreach(ARGV[0]) {|line|
	if line =~ reg # get identifier
		if !ident.nil?
			bib[ident] = keyVal #add previous stuff to hash when encountering next identifier line
		end
		ident = reg.match(line)[1] 
		keyVal={}
	elsif line =~ regEntry # get value of hash (consisting of a hash of type and value)
		#line.strip!
		#line.gsub!("\\\"O", "Oe")
		#line.gsub!("\\\"A", "Ae")
		#line.gsub!("\\\"U", "Ue")
		#line.gsub!("\\\"e", "e")
		#line.gsub!("\\\"i", "i")
		#line.gsub!("\\\"a", "ae")
		#line.gsub!("\\\"o", "oe")
		#line.gsub!("\\\"u", "ue")
		#line.gsub!("\\\&", "and")
		#line.gsub!("\\\'", "")
		#line.gsub!("\\\`", "")
		#line.gsub!("\\\~", "")
		#applySubstitutions(line)
		entry = regEntry.match(line)
		keyVal[entry[1]] = entry[2]	
	end	
}
bib[ident] = keyVal #add last item to hash

# empty arrays for handling different entries of hash
cites = []
mapA = []
mapB = []
mapC = []
mapD = []
books = []

# collection[collectionName].push(key)
#regLoc = /^\s*(file)\s*=\s*\{(:|.*;:)([a-zA-Z]+).txt.*$/
regL = /^.*\{(:|.*;:)([a-zA-Z]+)\.txt.*$/

# search hash for certain keys and values
bib.each_pair {|key, value|
	# push identifier into list of citations
	cites.push key 
	value.each_pair {|key2, value2|
		entry = regL.match(value2)
		p entry
		#if key2 = "file "
			
			
			
			#if value2 =~ /^.*mapA.*/
			#	mapA.push key
			#elsif value2 =~ /^.*mapB.*/
			#	mapB.push key
			#elsif value2 =~ /^.*mapC.*/
			#	mapC.push key
			#elsif value2 =~ /^.*mapD.*/
			#	mapD.push key
			#elsif value2 =~ /^.*books.*/
			#	books.push key
			#end
			
		
		
		#end
	}
} 








	#value2 = value["file"]
	#if value2 =~ /^.*mapA.*/ 
	#	mapA.push key 
	#elsif value2 =~ /^.*mapB.*/
		#mapB.push key
	#elsif value2 =~ /^.*mapC.*/
	#	mapC.push key
	#elsif value2 =~ /^.*mapD.*/
	#	mapD.push key
	#elsif value2 =~ /^.*books.*/
	#	books.push key



#for collection.each_pair {|k,v|
#	out = File.open("#{k}.txt", "w")
#	out.puts v.sort
#	out.close
#}


###### Get list of pdf files from directory  and save to file########
unless File.directory?("BibStuff") 
	Dir.mkdir("BibStuff")
end
Dir.chdir("BibStuff")

pdf_dir = ARGV[1] + "/*.pdf"
pdfs = Dir[pdf_dir]
pdfs = pdfs.map {|entry|
	File.basename(entry, ".pdf")
}

out = File.open("pdfs.txt", "w")
out.puts pdfs.sort
out.close

###### Getting everything together to compare #########
#get array of all copied articles
copies = mapA + mapB + mapC + mapD + books

#compare the lists
extra_pdfs = pdfs - cites
extra_cites = cites - pdfs - copies
pdf_prints = pdfs & copies

# make files of extra-stuff if not empty
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

out = File.open("overview.txt", "w")
out.puts "Used bib-file: #{ARGV[0]}! Pdfs from directory: #{ARGV[1]}!"
out.puts "Amount of pdfs: #{pdfs.length}" + ' (see "pdfs.txt")'
out.puts "Amount copies: #{copies.length}" 
out.puts "    of which in mapA: #{mapA.length}" +' (see "../mapA.txt")'
out.puts "    of which in mapB: #{mapB.length}" +' (see "../mapB.txt")'
out.puts "    of which in mapC: #{mapC.length}" +' (see "../mapC.txt")'
out.puts "    of which in mapD: #{mapD.length}" +' (see "../mapD.txt")'
out.puts "    of which books: #{books.length}" + ' (see "../books.txt")'
out.puts "Amount of citations: #{cites.length}"
out.print "Amount of pdf's not cited: #{extra_pdfs.length}" 
out.puts bib

if extra_pdfs.length  > 0
	out.puts " (see #{File.basename('"extraPDF.txt"')})" 
else
	out.puts ""
end
out.print "Amount of citations without text: #{extra_cites.length}" 
if
	out.puts " (see #{File.basename('"extraCITE.txt"')})"
else
	out.puts ""
end
out.print "Amount of prints that also are pdfs: #{pdf_prints.length}" 
if
	out.puts " (see #{File.basename('"pdfprint.txt"')})"
else
	out.puts ""	
end

out.close

puts "Amount of pdfs: #{pdfs.length}"
puts "Amount copies: #{copies.length}"
puts "Amount of citations: #{cites.length}"
puts "Amount of pdf's not cited: #{extra_pdfs.length}" 
puts "Amount of citations withou text: #{extra_cites.length}"
puts "Amount of prints that also are pdfs: #{pdf_prints.length}"
puts "Done! Check \"#{File.expand_path("")}\" for your output!"