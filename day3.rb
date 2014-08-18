#! /usr/bin/env ruby
class CsvRow
	attr_accessor  :headers,:row

	def method_missing(meth, *args, &blk)
		h = meth.to_s
		headers.zip(row) { |hd,rw| return rw if hd == h }		
	end

	def initialize (headers=[],row=[])
		@headers = headers
		@row = row
	end
end

module ActAsCsv
	def self.included(base)
		base.extend ClassMethods
	end

	module ClassMethods
		def acts_as_csv
			include InstanceMethods
		end
	end
	module InstanceMethods
		def read
			@csv_contents = []
			filename = self.class.to_s.downcase + '.txt'
			#print "filename:", filename,"\n"
			file = File.new(filename)
			@headers = file.gets.chomp.split(',')
			#print "headers:",@headers,"\n"
			file.each {|line| @csv_contents << line.chomp.split(',')}
			#print "csv_contents:",@csv_contents,"\n"
		end

		attr_accessor :headers,:csv_contents

		def initialize
			read
		end

		def each(&block)
			filename = self.class.to_s.downcase + '.txt'
			#print "filename:", filename,"\n"
			file = File.new(filename)
			headers = file.gets.chomp.split(',')
			#print "headers:",headers,"\n"
			#res = []
			file.each do |line|
				row = line.chomp.split(',')
				c =CsvRow.new
				c.headers = headers
				c.row = row
				#puts c.row
				yield c
				#res.push(c)
			end
			
		end
	end
end

class RubyCsv
	include ActAsCsv
	acts_as_csv
end

m = RubyCsv.new
m.each {|row| puts row.one}
