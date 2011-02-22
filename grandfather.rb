#!/usr/bin/env ruby
# encoding: UTF-8


def clock &clockproc
  
  now = Time.new.hour
  if now > 12
    now = now - 12
  end
  
  now.times do
    clockproc.call
  end
end


clock do
  puts 'DONG!'
end


