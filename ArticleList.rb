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
fh.close; out.close;

fh = File.open("articlesB.txt","r");
out = File.open("articlesC.txt","w");
fh.each { |line|
	out.puts line unless line =~ /Texte/
}
fh.close; out.close;


file_names = ['articlesC.txt']

file_names.each do |file_name|
  text = File.read(file_name)
  out = File.open('D:/Texte/articles.txt', "w")
  out.puts text.gsub(/.pdf/, "")
  
end


File.delete('articlesA.txt')
File.delete('articlesB.txt')
File.delete('articlesC.txt')