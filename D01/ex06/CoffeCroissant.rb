#!/usr/bin/env ruby -w

def my_var
	hashy = Hash.new()
	data = [
	['Frank', 33],
	['Stacy', 15],
	['Juan' , 24],
	['Dom' , 32],
	['Steve', 24],
	['Jill' , 24]
	]
	data.each do |cell|
		hashy[cell[0]] = cell[1]
	end
		test = hashy.sort_by {|k, v| [v, k] }.to_h
		test.each_key { |k| puts k }
end

my_var
