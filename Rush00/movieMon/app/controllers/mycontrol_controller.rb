
require 'uri'
require 'json'
require 'net/http'

$view = "home"
$player = { :position => [1, 1], :life => 20, :strength => 8, :moviedex_index => 0, :load_index => 0 }
$game = "off"
class MycontrolController < ApplicationController
  def index
      if (params.has_key?(:button))
        @button = params[:button]
      else
        @button = nil
      end
      get_view
  end
  def get_view
    if (params.has_key?(:view))
      $view = params[:view]
    end
    if $view == "off"
      if $game == "off"
        $game = "on"
        $view = "home"
      else
        $game = "off"
      end
    end
    check_load
    if $game ==  "off"
      off
    elsif $view == "home"
      home
    elsif $view == "load"
      load
    elsif $view == "map"
      map
    elsif $view == "battle"
      battle
    elsif $view == "defeat"
      if @button == 'A'
        $view = "map"
      end
    elsif $view == "victory"
      if @button == 'A'
        $view = "map"
      end
    elsif $view == "coward"
      coward
    elsif $view == "moviedex"
      moviedex
    end
  end
  def off

  end
  def home
    if @button == "start"
      $player[:position] = [1, 1]
      $player[:moviedex] = nil
      $view = "map"
    elsif @button == "select"
      $view = "load"
    end
  end
  def load
    if @button == "top"
      if $player[:load_index] > 0
        $player[:load_index] -= 1
      else
        $player[:load_index] = 2
      end
    elsif @button == "bottom"
      $player[:load_index] = ($player[:load_index] + 1) % 3
    elsif @button == "A"
      load_session
    elsif @button == "B"
      save_session
    elsif @button == "select"
      $view = "map"
    end
  end
  def check_load
    @file = []
    3.times { |i| @file.push(File.exist?("load#{i}.json") ? File.ctime("load#{i}.json").to_s.split('+')[0] : "empty") }
  end
  def save_session
    File.open("load#{$player[:load_index]}.json","w") do |f|
      f.write($player.to_json)
    check_load
    end
  end
  def load_session
    if @file[$player[:load_index]] != "empty"
      $player = JSON.parse(File.read("load#{$player[:load_index]}.json"), :symbolize_names => true)
    end
    $view = "map"
  end
  def moviedex
    if @button == "right"
      if $player[:moviedex_index] < $player[:moviedex].size - 1
        $player[:moviedex_index] += 1
      else
        $player[:moviedex_index] = 0
      end
    elsif @button == "left"
      if $player[:moviedex_index] > 0
        $player[:moviedex_index] -= 1
      else
        $player[:moviedex_index] = $player[:moviedex].size - 1
      end
    elsif @button == "start"
      $view = "map"
    end
  end
  def battle
    if @button == 'A'
      $player[:life] -= $selected[:strength]
      $selected[:life] -= $player[:strength]
      if $player[:life] <= 0 && $player[:life] <= $selected[:life]
        $player[:life] = 20
        $view = "defeat"
      elsif $selected[:life] <= 0
        $player[:life] = 20
        $view = "victory"
        load_moviedex
      end
    elsif @button == 'B'
      $player[:life] = 20
      $view = "coward"
    end
  end
  def coward
    if @button == 'A'
      $view = "map"
    end
  end
  def map
    if @button == "start"
      if $player[:moviedex] != nil
        $view = "moviedex"
      end
    elsif @button == "select"
      $view = "load"
    elsif is_arrow
      if @button == "top"
        if $player[:position][0] > 0
          $player[:position][0] -= 1
        end
      elsif @button == "bottom"
        if $player[:position][0] < 9
          $player[:position][0] += 1
        end
      elsif @button == "left"
        if $player[:position][1] > 0
          $player[:position][1] -= 1
        end
      elsif @button == "right"
        if $player[:position][1] < 9
          $player[:position][1] += 1
        end
      end
      if is_moviemon
        $view = "battle"
        get_new_movie
        puts @movie_list
      end
    end
  end
  def is_arrow
    return @button == "top" || @button == "bottom" || @button == "right" || @button == "left"
  end
  def is_moviemon
    return Random.rand(100) > 70
  end
  def get_new_movie
   parsed = JSON.parse(Net::HTTP.get(URI('https://random-movie.herokuapp.com/random')))
   $selected = @movie_list = {
     :Title => parsed['Title'],
     :Year => parsed['Year'],
     :Genre => parsed['Genre'],
     :Director => parsed['Director'],
     :Synopsis => parsed['Plot'],
     :Poster => parsed['Poster'],
     :imdbRating => parsed['imdbRating'],
     :strength => parsed['imdbRating'].to_i,
     :life => 20,
   }
  end
  def load_moviedex
    $player[:moviedex] ||= []
    $player[:moviedex] << $selected
  end
end
