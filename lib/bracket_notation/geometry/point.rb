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
    # Point represents a point on a cartesian plane using an x and y fields.
    class Point
      attr_reader :x, :y
      
      def initialize(x = 0, y = 0)
        @x = x
        @y = y
      end
      
      # Test to see if two points are equal, where equality is defined as having
      # identical X and Y values
      def ==(rvalue)
        @x == rvalue.x && @y == rvalue.y
      end
      
      # Create a new point by adding the given amount to the current point's X value
      def point_by_adding_to_x(delta_x)
        self.class.new(@x + delta_x, @y)
      end
      
      # Create a new point by adding the given amount to the current point's Y value
      def point_by_adding_to_y(delta_y)
        self.class.new(@x, @y + delta_y)
      end
      
      # Create a new point by adding the given amounts to the current point's X and
      # Y values
      def point_by_adding_to_x_and_y(delta_x, delta_y)
        self.class.new(@x + delta_x, @y + delta_y)
      end
      
      def inspect
        "{x: #{@x}, y: #{@y}}"
      end
      
      alias :to_s :inspect
    end
  end
end
