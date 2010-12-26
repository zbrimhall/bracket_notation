#--
# This file is part of BracketNotation.
# 
# BracketNotation is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# BracketNotation is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with BracketNotation.  If not, see <http://www.gnu.org/licenses/>.
#++
# BracketNotation is a parser for generating syntax trees from sentences
# annotated with the kind of bracket notation that is commonly used by
# linguists. The result is a tree structure with nodes that describe the phrases
# and constituents of the sentence.
#
# BracketNotation was inspired by Yoichiro Hasebe's RSyntaxTree[http://yohasebe.com/rsyntaxtree/],
# and small portions of his code have been incorporated in the parser.
#
# Author:: Cody Brimhall (mailto:brimhall@somuchwit.com)
# Copyright:: Copyright (c) 2010 Cody Brimhall
# License:: Distributed under the terms of the GNU General Public License, v. 3

require 'rubygems'
require 'rake'
require 'echoe'
require 'lib/bracket_notation'

Echoe.new('bracket_notation', BracketNotation::Version) do |p|
  p.description = "Generates a representation of a syntax tree using a string of bracket notation."
  p.summary = "Provides a parser for strings that have been marked up with the bracket notation commonly used by syntacticians. The parser generates an abstract tree representation of the syntax of the string."
  p.url = "http://github.com/zbrimhall/bracket_notation"
  p.author = "Cody Brimhall"
  p.email = "zbrimhall@gmail.com"
  p.ignore_pattern = %w(tmp/* script/* *.bbprojectd/*)
  p.development_dependencies = []
end

Dir[File.join(File.dirname(__FILE__), "tasks", "*.rake")].sort.each {|ext| load ext}
