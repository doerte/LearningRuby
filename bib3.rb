##### Define some stuff needed later #######
keyVal ={}
identifiers ={}
bib = {}
ident = []
cache =[]
reg = /^\s*@[a-zA-Z]+\{([^,]+),/
regEntry = /^\s*([^@]+)\s*=\s*\{([^\}]+).*$/
out = File.open("bib2.txt","w")
output =[]
###### Make hash of hashes from bibtex file #####

File.foreach(ARGV[0]) {|line|
	if line =~ reg # get identifier
		if ident[1] != nil
			bib[ident[1]] = keyVal #add previous stuff to hash when encountering next identifier line
		end
		ident = reg.match(line) 
		keyVal={}
			
	elsif line =~ /[^\}]\,$/ 
		cache.push line
	elsif line =~ regEntry # get value of hash (consisting of a hash of type and value)
		line.strip!
		line.gsub!("\\\"O", "Oe")
		line.gsub!("\\\"A", "Ae")
		line.gsub!("\\\"U", "Ue")
		line.gsub!("\\\"e", "e")
		line.gsub!("\\\"i", "i")
		line.gsub!("\\\"a", "ae")
		line.gsub!("\\\"o", "oe")
		line.gsub!("\\\"u", "ue")
		line.gsub!("\\\&", "and")
		line.gsub!("\\\'", "")
		line.gsub!("\\\`", "")
		line.gsub!("\\\~", "")
			
		cache.push line
		cache.map {|input| 
		output.push input
		}
		output.flatten!
		output = output.to_s
		entry = regEntry.match(output)
		keyVal[entry[1]] = output
		cache = []
		output =[]
	
		
	end	
}
bib[ident[1]] = keyVal #add last item to hash



#out.puts bib
out.puts bib
out.close
puts "Done! Check \"#{File.expand_path("bib2.txt")}\" for your output!"
