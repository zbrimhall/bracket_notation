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
    # Rect represents a rectangle by means of origin and size fields.
    class Rect
      attr_reader :origin, :size
      
      # Initialize the new instance. If the first two parameters are a Point and
      # a Size, they will be used as the origin and size of the node rect
      # respectively. If not, it is assumed that they are numeric values
      # corresponding to the new node's origin coordinates, and they along with
      # the optional last two parameters will be used to initialize new Point
      # and Size objects to use for the rect.
      def initialize(origin_or_x = Point.new, size_or_y = Size.new, width = 0, height = 0)
        if origin_or_x.kind_of? Point and size_or_y.kind_of? Size
          @origin = origin_or_x
          @size = size_or_y
        else
          @origin = Point.new(origin_or_x, size_or_y)
          @size = Size.new(width, height)
        end
      end
      
      # Test to see if two points are equal, where equality is defined as having
      # identical origins and sizes
      def ==(rvalue)
        @origin == rvalue.origin && @size == rvalue.size
      end
      
      def inspect
        "{origin: #{@origin.inspect}, size: #{@size.inspect}}"
      end
      
      alias :to_s :inspect
    end
  end
end
