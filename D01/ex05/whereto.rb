#!/usr/bin/env ruby -w

def lol
	states = {
		"Oregon" => "OR",
		"Alabama" => "AL",
		"New Jersey" => "NJ",
		"Colorado" => "CO"
	}
	capitals_cities = {
		"OR" => "Salem",
		"AL" => "Montgomery",
		"NJ" => "Trenton",
		"CO" => "Denver"
	}
	myList = ARGV[0].split(',').map{ |x| x.strip.split(' ').map(&:capitalize).join(' ')}
	myList.each do |line|
		state = states.has_key? line
		capital = capitals_cities.has_value? line
		if ARGV.size > 1
			return
		elsif state
			state = line
			capital = capitals_cities[states[line]]
			puts "#{capital} is he capital of #{state} (akr: #{states[state]})"
		elsif capital
			state = states.key(capitals_cities.key(line))
			capital = line
			puts "#{capital} is he capital of #{state} (akr: #{states[state]})"
		elsif !state && !capital
			if line.to_s == ''
				next
			else
				puts "#{line} is neither a capital city nor a state"
			end
		end
	end
end

lol
