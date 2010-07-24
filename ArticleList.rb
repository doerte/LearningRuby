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