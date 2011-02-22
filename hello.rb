if ARGV.length < 1
	puts "You need to provide your name as an argument!"
	Process.exit
end

require 'Qt'

a = Qt::Application.new(ARGV)
hello = Qt::PushButton.new("Click here to close, #{ARGV[0]}!", nil)
hello.resize(200, 30)
Qt::Object.connect(hello, SIGNAL('clicked()'), a, SLOT('quit()'))
#a.setMainWidget(hello)
hello.show()
a.exec()