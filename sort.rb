def lineCompare(a, b)
	markerA = a.split('=')[0].gsub('Mk', '')
	markerB = b.split('=')[0].gsub('Mk', '')
	
	markerA.to_i <=> markerB.to_i
end

# arr.sort {|a,b|
#   markerA = a.split('=')[0].gsub('Mk', '')
#   markerB = b.split('=')[0].gsub('Mk', '')
#   markerA.to_i <=> markerB.to_i
# }
#