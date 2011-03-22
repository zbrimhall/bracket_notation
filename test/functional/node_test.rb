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

require 'test_helper'

class NodeTest < Test::Unit::TestCase
  context "any node" do
    setup do
      @tree = BracketNotation::View::Tree.new("[A [B [E] [F]] [C] [D]]")
      @root = BracketNotation::View::Node.new(@tree, "A")
      @child1 = BracketNotation::View::Node.new(@tree, "B")
      @child2 = BracketNotation::View::Node.new(@tree, "C")
      @child3 = BracketNotation::View::Node.new(@tree, "D")
      @child4 = BracketNotation::View::Node.new(@tree, "E")
      @child5 = BracketNotation::View::Node.new(@tree, "F")
      
      @child1.children += [@child4, @child5]
      @child4.parent = @child1
      @child5.parent = @child1
      
      @root.children += [@child1, @child2, @child3]
      @child1.parent = @root
      @child2.parent = @root
      @child3.parent = @root
      
      @tree.root = @root
      
      @root.rect = BracketNotation::Geometry::Rect.new(BracketNotation::Geometry::Point.new(0,0), BracketNotation::Geometry::Size.new(42,42))
    end
    
    should "know its parent" do
      assert_same @child1.parent, @root
    end
    
    should "know its children" do
      assert_equal @root.children, [@child1, @child2, @child3]
      assert_equal @child1.children, [@child4, @child5]
      assert_equal @child4.children, []
    end
    
    should "know its ancestors" do
      assert_equal @root.ancestors, []
      assert_equal @child1.ancestors, [@root]
      assert_equal @child4.ancestors, [@child1, @root]
    end
    
    should "know its left sibling" do
      assert_same @child2.left_sibling, @child1
      assert_nil @child1.left_sibling
    end
    
    should "know its right sibling" do
      assert_same @child2.right_sibling, @child3
      assert_nil @child3.right_sibling
    end
    
    should "know its tree" do
      assert_same @root.tree, @tree
      assert_same @child1.tree, @tree
      assert_same @child4.tree, @tree
    end
    
    should "know its corners" do
      assert_equal @root.corner_top_left, BracketNotation::Geometry::Point.new(0,0)
      assert_equal @root.corner_top_right, BracketNotation::Geometry::Point.new(42,0)
      assert_equal @root.corner_bottom_right, BracketNotation::Geometry::Point.new(42,42)
      assert_equal @root.corner_bottom_left, BracketNotation::Geometry::Point.new(0,42)
    end
    
    should "know its side midpoints" do
      assert_equal @root.side_middle_top, BracketNotation::Geometry::Point.new(21,0)
      assert_equal @root.side_middle_right, BracketNotation::Geometry::Point.new(42, 21)
      assert_equal @root.side_middle_bottom, BracketNotation::Geometry::Point.new(21,42)
      assert_equal @root.side_middle_left, BracketNotation::Geometry::Point.new(0, 21)
    end
  end
  
  context "a branch node" do
    setup do
      @tree = BracketNotation::View::Tree.new("[A [B [E] [F]] [C] [D]]")
      @root = BracketNotation::View::Branch.new(@tree, "A")
      @child1 = BracketNotation::View::Branch.new(@tree, "B")
      @child2 = BracketNotation::View::Leaf.new(@tree, "C")
      @child3 = BracketNotation::View::Leaf.new(@tree, "D")
      @child4 = BracketNotation::View::Leaf.new(@tree, "E")
      @child5 = BracketNotation::View::Leaf.new(@tree, "F")
      
      @child1.children += [@child4, @child5]
      @child4.parent = @child1
      @child5.parent = @child1
      
      @root.children += [@child1, @child2, @child3]
      @child1.parent = @root
      @child2.parent = @root
      @child3.parent = @root
      
      @tree.root = @root
      
      @root.rect = BracketNotation::Geometry::Rect.new(BracketNotation::Geometry::Point.new(0,0), BracketNotation::Geometry::Size.new(42,42))
    end
    
    should "start out unrolled" do
      assert !@root.roll_up
      assert !@child1.roll_up
    end
  end
end
