require "ft_wikipedia/version"
require 'open-uri'
require 'Nokogiri'

module Ft_Wikipedia

	class Ft_Wikipedia

		def initialize
		end

		def search(string)
			page = Nokogiri::HTML(open("https://fr.wikipedia.org/wiki/#{string}"))
			page.css('body').css('ul').css('a').each do |a|
				puts a['href']
				lol = a.childre.read
				puts lol
			end
		end
	end
end
