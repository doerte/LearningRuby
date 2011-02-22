#!/usr/bin/env ruby -wKU
# encoding: UTF-8

def log name, &block
  puts 'Beginning "' + name + '" ...'
  result = block.call
  puts '..."' + name + '" finished, returning:' + result.to_s
end


log 'outer block' do
  log 'some little block' do
    8
  end
  log 'yet another block' do
    10
  end
  5
end
