#!/usr/bin/env ruby -w

class Elem
	attr_reader :tag, :content, :tag_type, :opt
	def initialize(balise="", content=Array[], tag_type="double",  opt={})
		@tag =  balise
		@content =  content
		@tag_type =  tag_type
		@opt = opt
	end
	def add_content(*params)
		params.each do |param|
			@content << param
		end
	end
	def to_s
		string = "<#{@tag}"
		if @tag_type == "double"
			string += ">"
		end
		if !@content
			string += "\n"
		end

		if (@content.class != String) && (@content.class != Text)
			string += "\n"
			@content.each do |value|
				string += value.to_s
				if !value.equal?(@content.last) || @content.count == 1
					string += "\n"
				end
			end
		else
			string += @content.to_s
		end
		if !@opt
				@content.each do |value|
					string += value.to_s
				end
		elsif
			@opt.each do |k, v|
				string += " #{k}='#{v}'"
			end
		end
		if @tag_type == "simple"
			string += " />\n"
		elsif
			if @tag == 'html'
				string += "\n</#{@tag}>"
			else
				string += "</#{@tag}>"
			end
		end
		return string
	end
end

class Text
	attr_reader :string
	def initialize(string)
		@string = string
		self.to_s
	end
	def to_s
		@string
	end
end
