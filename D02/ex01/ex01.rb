#!/usr/bin/env ruby -w

class Html
	attr_reader :title

	def initialize(title)
		@page_name = title
		self.head
	end

	def head
		begin
			if File.file? ("#{@page_name}.html")
				raise "A file named #{@page_name}.html already exist!"
			end
		end
		file = File.open("#{@page_name}.html", "w")
		file << "<!DOCTYPE html>\n"
		file << "<html>\n"
		file << "<head>\n"
		file << "<title>#{@page_name}</title>\n"
		file << "</head>\n"
		file << "<body>\n"
		file.close
	end

	def dump(str)
		begin
			if File.readlines("#{@page_name}.html").grep(/<body>/).size == 0
				raise "There is no body tag in #{@page_name}.html"

			elsif File.readlines("#{@page_name}.html").grep(/<\/body>/).size > 0
				raise "Body has already been closed in #{@page_name}.html"
			else
				file = File.open("#{@page_name}.html", "a")
				file << "<p>#{str}</p>\n"
				file.close
			end
		end
	end

	def finish
		begin
			if File.readlines("#{@page_name}.html").grep(/<\/body>/).size > 0
				raise "#{@page_name}.html has already been closed"
			else
				file = File.open("#{@page_name}.html", "a")
				file.write "</body>"
				file.close
			end
		end
	end
end

if $PROGRAM_NAME == __FILE__
  a = Html.new("xD")
  10.times{|x| a.dump("fucking sujet #{x}")}
  a.finish
  a = Html.new("xD")
end
