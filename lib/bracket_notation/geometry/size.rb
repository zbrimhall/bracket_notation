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
# Copyright:: Copyright (c) 2010-2011 Cody Brimhall
# License:: Distributed under the terms of the GNU General Public License, v. 3

module BracketNotation # :nodoc:
  module Geometry # :nodoc:
    # Size represents the size of a rectangle using a width and height field.
    class Size
      attr_reader :width, :height
      
      def initialize(width = 0, height = 0)
        @width = width
        @height = height
      end
      
      # Test to see of two sizes are equal, where equality is defined as having
      # identical widths and heights
      def ==(rvalue)
        @width == rvalue.width && @height == rvalue.height
      end
      
      # Create a new size by adding the given amount to the current size's width
      def size_by_adding_to_width(delta_width)
        self.class.new(@width + delta_width, @height)
      end
      
      # Create a new size by adding the given amount to the current size's height
      def size_by_adding_to_height(delta_height)
        self.class.new(@width, @height + delta_height)
      end
      
      # Create a new size by adding the given amounts to the current size's width
      # and height
      def size_by_adding_to_width_and_height(delta_width, delta_height)
        self.class.new(@width + delta_width, @height + delta_height)
      end
      
      def inspect
        "{width: #{@width}, height: #{@height}}"
      end
      
      alias :to_s :inspect
    end
  end
end
