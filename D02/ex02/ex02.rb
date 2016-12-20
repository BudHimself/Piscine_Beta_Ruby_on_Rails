#!/usr/bin/env ruby -w

class Dup_file < StandardError
   attr_reader :name

   def initialize(name)
	   @file_name = name
   end

   def show_state
	   if File.file? ("#{@file_name}.html")
		   @path = "#{Dir.pwd}/#{@file_name}.html"
		   puts "A file named #{@file_name}.html was already there: #{@path}"
		   self.correct
	   end
   end

   def correct
	   if File.file? ("#{@file_name}.html")
		   @file_name = @file_name + ".new"
		   self.explain
	   end
	   return @file_name
   end

   def explain
	   if File.file? ("#{@file_name}.html")
		   self.show_state
	   else
		   puts "Appended .new in order to create requested file: #{Dir.pwd}/#{@file_name}.html"
	   end
   end
end

class Body_closed < StandardError
   attr_reader :file

   def initialize(file)
	   @file = file
   end

   def show_state
	   puts "In #{@file} body was closed :"
   end

   def correct
	   file_te = File.open("#{@file}.html", "r") { |f| f.read.split("\n") }
	   @file_te = file_te.index("</body>")
	   file_te.delete("</body>")
	   file_te = File.open("#{@file}.html", "w") { |f| f.write(file_te.join("\n") + "\n") }
     self.explain
   end

   def explain
     puts "> ln :#{@file_te} </body> : text has been inserted and tag moved at end of it"
   end
end

class Html
   attr_reader :title

   def initialize(title)
	   @page_name = title
	   self.head
   end

   def head
	   begin
		   if File.file? ("#{@page_name}.html")
			   raise Dup_file.new "#{@page_name}"
		   end
	   rescue Dup_file => e
		   e.show_state
		   @page_name = e.correct
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
			   raise Body_closed.new "#{@page_name}"
		   end
		   file = File.open("#{@page_name}.html", "a")
		   file << "<p>#{str}</p>\n"
		   file.close
	   rescue Body_closed => e
		   e.show_state
		   e.correct
		   file = File.open("#{@page_name}.html", "a")
		   file << "<p>#{str}</p>\n"
		   file << "</body>\n"
		   file.close
	   end
   end

   def finish
	   begin
		   if File.readlines("#{@page_name}.html").grep(/<\/body>/).size > 0
			   puts File.readlines("#{@page_name}.html").grep(/<\/body>/).size
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
  a.dump("xDDDDDD")
  a.dump("ca marrrrche")
  a.dump("ca marrrrche")
  a = Html.new("xD")
  a = Html.new("xD")
  a = Html.new("xD")
  a.finish
end
