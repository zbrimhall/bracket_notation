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
      attr_accessor :tree, :content, :parent, :children, :rect, :align_to_grid
      
      def initialize(tree, content)
        @tree = tree
        @content = content
        @parent = nil
        @children = []
        @rect = BracketNotation::Geometry::Rect.new
        @align_to_grid = true
      end
      
      # Custom setter for the node rect. If @align_to_grid is true, rect co-
      # ordinates and dimensions will be rounded to the nearest integer.
      def rect=(rvalue)
        return if @rect == rvalue
        
        @rect = if @align_to_grid
          adjusted_origin = BracketNotation::Geometry::Point.new(rvalue.origin.x.round, rvalue.origin.y.round)
          adjusted_size = BracketNotation::Geometry::Size.new(rvalue.size.width.round, rvalue.size.height.round)
          BracketNotation::Geometry::Rect.new(adjusted_origin, adjusted_size)
        else
          rvalue
        end
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
      
      # Return the dimensions of the rect that contains the nod and all of its
      # descendants
      def subtree_size
        return @rect.size if kind_of? Leaf or @children.count == 0
        
        new_subtree_size = BracketNotation::Geometry::Size.new(0, @rect.size.height)
        subtree_widths = []
        subtree_heights = []
        
        @children.each do |child|
          child_subtree_size = child.subtree_size
          new_subtree_size = new_subtree_size.size_by_adding_to_width(child_subtree_size.width)
          subtree_heights << child_subtree_size.height
        end
        
        new_subtree_size = new_subtree_size.size_by_adding_to_width_and_height(@tree.node_h_margin * (children.count - 1), @tree.node_v_margin + subtree_heights.sort.last)
        return BracketNotation::Geometry::Size.new(@rect.size.width > new_subtree_size.width ? @rect.size.width : new_subtree_size.width, new_subtree_size.height)
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
