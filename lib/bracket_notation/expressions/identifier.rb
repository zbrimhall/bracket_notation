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

module BracketNotation # :nodoc:
  # This class represents an identifier expression. Identifers are expressions
  # that can have children -- branch nodes, in other words.
  class Identifier < Expression
    attr_accessor :children, :depth
    
    # Saves the identifier value and optional tree depth.
    def initialize(value, depth = 0)
      super
      @children = []
    end
    
    # Adds the given expression to the children array and updates the new
    # child's parent and depth attributes.
    def add_child(expression)
      expression.parent = self
      expression.depth = @depth + 1
      @children << expression
    end
    
    # Sets the new depth, and the new depth of all children.
    def depth=(rvalue)
      @depth = rvalue
      children.each {|child| child.depth = rvalue + 1}
    end
    
    # Prints a visual representation of the syntax tree.
    def pretty_print
      out = super
      @children.each {|child| out << child.pretty_print}
      out
    end
  end
end
