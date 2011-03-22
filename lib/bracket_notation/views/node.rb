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

require 'bracket_notation/geometry'

module BracketNotation # :nodoc:
  module View # :nodoc:
    class Node
      attr_accessor :tree, :content, :parent, :children, :rect
      
      def initialize(tree, content)
        @tree = tree
        @content = content
        @parent = nil
        @children = []
        @rect = BracketNotation::Geometry::Rect.new
      end
    
      # Return the node's left sibling, or nil if the node is the leftmost child of
      # its parent.
      def left_sibling
        return nil if @parent.nil?
        
        left_sibling = nil
        self_index = @parent.children.index(self)
        left_sibling = @parent.children[self_index - 1] if self_index > 0
        
        return left_sibling
      end
    
      # Return the node's right sibling, or nil if the node is the rightmost child
      # of its parent.
      def right_sibling
        return nil if @parent.nil?
        
        self_index = @parent.children.index(self)
        right_sibling = @parent.children[self_index + 1]
        
        return right_sibling
      end
      
      # Return the list of nodes leading from the current node to the tree root,
      # starting with the current node's parent.
      def ancestors
        node_list = []
        next_up = self
        node_list << next_up while next_up = next_up.parent
        
        return node_list
      end
      
      # Return the coordinates of the node's top left corner.
      def corner_top_left
        @rect.origin
      end
      
      # Return the coordinates of the node's top right corner.
      def corner_top_right
        BracketNotation::Geometry::Point.new(@rect.origin.x + @rect.size.width, @rect.origin.y)
      end
      
      # Return the coordinates of the node's bottom right corner.
      def corner_bottom_right
        BracketNotation::Geometry::Point.new(@rect.origin.x + @rect.size.width, @rect.origin.y + @rect.size.height)
      end
      
      # Return the coordinates of the node's bottom left corner.
      def corner_bottom_left
        BracketNotation::Geometry::Point.new(@rect.origin.x, @rect.origin.y + @rect.size.height)
      end
      
      # Return the coordinates of the middle of the node's top side.
      def side_middle_top
        BracketNotation::Geometry::Point.new(@rect.origin.x + (@rect.size.width / 2), @rect.origin.y)
      end
      
      # Return the coordinates of the middle of the node's right side.
      def side_middle_right
        BracketNotation::Geometry::Point.new(@rect.origin.x + @rect.size.width, @rect.origin.y + (@rect.size.height / 2))
      end
      
      # Return the coordinates of the middle of the node's bottom side.
      def side_middle_bottom
        BracketNotation::Geometry::Point.new(@rect.origin.x + (@rect.size.width / 2), @rect.origin.y + @rect.size.height)
      end
      
      # Return the coordinates of the middle of the node's left side.
      def side_middle_left
        BracketNotation::Geometry::Point.new(@rect.origin.x, @rect.origin.y + (@rect.size.height / 2))
      end
    end
  end
end
