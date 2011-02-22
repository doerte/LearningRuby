#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$nesting_depth = 0

def log name, &block
  puts '  '*$nesting_depth + 'Beginning "' + name + '" ...'
  $nesting_depth = $nesting_depth + 1
  result = block.call
  $nesting_depth = $nesting_depth - 1
  puts '  '*$nesting_depth + '..."' + name + '" finished, returning:' + result.to_s
end


log 'outer block' do
  log 'some little block' do
    log 'teeny-tiny block' do
      'bla'
    end
    8
  end
  
  log 'yet another block' do
    10
  end
  5
end
