require "deepthough/version"

require 'colorize'

module Deepthough
	class Deepthough

		def initialize
		end

		def respond(question)
			if question == "The Ultimate Question of Life, the Universe and Everything"
				puts "42".green
				return "42"
			else
				puts "Mmmm i'm bored".red
				return "Mmmm i'm bored"
			end
		end
	end
end
