#!/usr/bin/env ruby
puts "hello world!"

#day 2
a = [5,4,3,1]
a.inject do |sum,i|
	puts "sum:#{sum},i=#{i},sum*i:#{sum*i}"
	sum * i
end

numbers = {1=>'one',2=>'two'}
puts numbers.values.to_a
puts numbers.keys.to_a

h = a.map { |e| e**2 }
puts h

(1..16).to_a.each_slice(4) {|a| puts a.each {|i| i}.join(',')}

f = File.new("d.txt")
f.each {|line| puts "#{f.lineno}:#{line}" if line.match("gjl")}

#day 3