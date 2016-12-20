#!/usr/bin/env ruby -w

class Html
	attr_reader :title
	def initialize(title)
		@page_name = title
		self.head
	end

	def head
		file = File.new("#{@page_name}.html", "w")
		file.write("<!doctype html>\n")
		file.write("<html>\n")
		file.write("<head>\n")
		file.write("<title>#{@page_name}</title>\n")
		file.write("</head>\n")
		file.write("<body>\n")
	end

	def dump(string)
		file = File.open("#{@page_name}.html", "a")
		file.write("  <p>#{string}</p>\n")
	end

	def finish
		file = File.open("#{@page_name}.html", "a")
		file.write("</body>\n")
	end
end

if $PROGRAM_NAME == __FILE__
  a = Html.new("xD")
  20.times{|x| a.dump("fucking sujet #{x}")}
  puts a.dump("fucking sujet #{x}").to_s.class
  a.finish
end
