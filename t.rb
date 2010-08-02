

##### Define some stuff needed later #######
keyVal ={}
identifiers ={}
bib = {}
ident = nil
reg = /^\s*@[a-zA-Z]+\{([^,]+),/
regEntry = /^\s*([^@]+)\s*=\s*\{([^\}]+).*$/#### Make hash of hashes from bibtex file #####
regLoc = /^\s*(file)\s*=\s*\{(:|.*;:)([a-zA-Z]+).*$/


File.foreach(ARGV[0]) {|line|
	if line =~ regLoc # get value of hash (consisting of a hash of type and value)
		entry = regLoc.match(line)
		p "#{entry[1]} = #{entry[3]}"
	end	
}



