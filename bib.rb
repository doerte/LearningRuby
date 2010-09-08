#### Get hash of Bib-entries #####

if ARGV.length != 1
	puts "You need to provide 1 arguments, please enter path to the bib-file!"
	Process.exit
else
	puts "Your bib-file is: #{ARGV[0]}!"
end
keyVal ={}
identifiers ={}
bib = {}
ident = []
reg = /^\s*@[a-zA-Z]+\{([^,]+),/
regEntry = /^\s*([^@]+)\s*=\s*\{([^\}]+).*$/
out = File.open("bib.txt","w")

File.foreach(ARGV[0]) {|line|
	if line =~ reg
		if ident[1] != nil
			bib[ident[1]] = keyVal
		end
		ident = reg.match(line)
		keyVal={}
	elsif line =~ regEntry 
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
		entry = regEntry.match(line)
		keyVal[entry[1]] = entry[2]	
	end	
}
bib[ident[1]] = keyVal

out.puts bib
out.close
puts "Done! Check \"#{File.expand_path("bib.txt")}\" for your output!"