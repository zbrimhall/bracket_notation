require 'rubygems'
require 'rake'
require 'echoe'
require File.join(File.dirname(__FILE__), "lib", "bracket_notation")

Echoe.new('bracket_notation', BracketNotation::Version) do |p|
  p.description = "Generate a representation of a syntax tree using a string of bracket notation."
  p.url = "http://github.com/zbrimhall/bracket_notation"
  p.author = "Cody Brimhall"
  p.email = "zbrimhall@gmail.com"
  p.ignore_pattern = %w(tmp/* script/*)
  p.development_dependencies = []
end

Dir[File.join(File.dirname(__FILE__), "tasks", "*.rake")].sort.each {|ext| load ext}
