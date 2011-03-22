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

class LayoutTest < Test::Unit::TestCase
  include BracketNotation
  include BracketNotation::View
  include BracketNotation::Geometry
  
  SANS_FONT_NAME = "Helvetica"
  SERIF_FONT_NAME = "Georgia"
  DEFAULT_METRICS = {:large => {:font_point_size => 40,
                                :tree_padding    => 20,
                                :node_h_margin   => 50,
                                :node_v_margin   => 30,
                                :node_padding    => 10},
                                
                     :small => {:font_point_size => 12,
                                :tree_padding    => 20,
                                :node_h_margin   => 20,
                                :node_v_margin   => 15,
                                :node_padding    => 10}}
  
  context "a single-node tree" do
    setup do
      @input = "[S]"
      @tree = Tree.new(@input)
      @root = Branch.new(@tree, "S")
      @tree.root = @root
    end
    
    should "layout correctly at large point sizes" do
      size = :large
      metrics = DEFAULT_METRICS[size]
      configure_tree(@tree, :size => size)
      @tree.compute_layout
      
      correct_root_origin = Point.new(metrics[:tree_padding], metrics[:tree_padding])
      correct_root_size = Size.new(24, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_root_rect = Rect.new(correct_root_origin, correct_root_size)
      
      assert_equal correct_root_rect, @root.rect
    end
    
    should "layout correctly at small point sizes" do
      size = :small
      metrics = DEFAULT_METRICS[size]
      configure_tree(@tree, :size => size)
      @tree.compute_layout
      
      correct_root_origin = Point.new(metrics[:tree_padding], metrics[:tree_padding])
      correct_root_size = Size.new(7, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_root_rect = Rect.new(correct_root_origin, correct_root_size)
      
      assert_equal correct_root_rect, @root.rect
    end
  end
  
  context "a two-node tree" do
    setup do
      @input = "[S [NP]]"
      @tree = Tree.new(@input)
      @root = Branch.new(@tree, "S")
      @child = Branch.new(@tree, "NP")
      
      @child.parent = @root
      @root.children << @child
      @tree.root = @root
    end
    
    should "layout correctly at large point sizes" do
      size = :large
      metrics = DEFAULT_METRICS[size]
      configure_tree(@tree, :size => size)
      @tree.compute_layout
      
      correct_root_origin = Point.new(34, metrics[:tree_padding])
      correct_root_size = Size.new(24, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_root_rect = Rect.new(correct_root_origin, correct_root_size)
      
      correct_child_origin = Point.new(metrics[:tree_padding], metrics[:tree_padding] + correct_root_size.height + metrics[:node_v_margin])
      correct_child_size = Size.new(52, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_child_rect = Rect.new(correct_child_origin, correct_child_size)
      
      assert_equal correct_root_rect, @root.rect, "The root rect is wrong"
      assert_equal correct_child_rect, @child.rect, "The child rect is wrong"
    end
    
    should "layout correctly at small point sizes" do
      size = :small
      metrics = DEFAULT_METRICS[size]
      configure_tree(@tree, :size => size)
      @tree.compute_layout
      
      correct_root_origin = Point.new(24.5, metrics[:tree_padding])
      correct_root_size = Size.new(7, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_root_rect = Rect.new(correct_root_origin, correct_root_size)
      
      correct_child_origin = Point.new(metrics[:tree_padding], metrics[:tree_padding] + correct_root_size.height + metrics[:node_v_margin])
      correct_child_size = Size.new(16, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_child_rect = Rect.new(correct_child_origin, correct_child_size)
      
      assert_equal correct_root_rect, @root.rect, "The root rect is wrong"
      assert_equal correct_child_rect, @child.rect, "The child rect is wrong"
    end
  end
  
  context "a three-node tree" do
    setup do
      @input = "[S [NP] [VP]]"
      @tree = Tree.new(@input)
      @root = Branch.new(@tree, "S")
      @child1 = Branch.new(@tree, "NP")
      @child2 = Branch.new(@tree, "VP")
      
      @child1.parent = @root
      @child2.parent = @root
      @root.children += [@child1, @child2]
      @tree.root = @root
    end
    
    should "layout correctly at large point sizes" do
      size = :large
      metrics = DEFAULT_METRICS[size]
      configure_tree(@tree, :size => size)
      @tree.compute_layout
      
      correct_root_origin = Point.new(84.8984375, metrics[:tree_padding])
      correct_root_size = Size.new(24, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_root_rect = Rect.new(correct_root_origin, correct_root_size)
      
      correct_child1_origin = Point.new(19.8984375, metrics[:tree_padding] + correct_root_size.height + metrics[:node_v_margin])
      correct_child1_size = Size.new(52, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_child1_rect = Rect.new(correct_child1_origin, correct_child1_size)
      
      correct_child2_origin = Point.new(122, metrics[:tree_padding] + correct_root_size.height + metrics[:node_v_margin])
      correct_child2_size = Size.new(51.796875, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_child2_rect = Rect.new(correct_child2_origin, correct_child2_size)
      
      assert_equal correct_root_rect, @root.rect, "The root rect is wrong"
      assert_equal correct_child1_rect, @child1.rect, "The first child's rect is wrong"
      assert_equal correct_child2_rect, @child2.rect, "The second child's rect is wrong"
    end
    
    should "layout correctly at small point sizes" do
      size = :small
      metrics = DEFAULT_METRICS[size]
      configure_tree(@tree, :size => size)
      @tree.compute_layout
      
      correct_root_origin = Point.new(42.3203125, metrics[:tree_padding])
      correct_root_size = Size.new(7, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_root_rect = Rect.new(correct_root_origin, correct_root_size)
      
      correct_child1_origin = Point.new(19.8203125, metrics[:tree_padding] + correct_root_size.height + metrics[:node_v_margin])
      correct_child1_size = Size.new(16, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_child1_rect = Rect.new(correct_child1_origin, correct_child1_size)
      
      correct_child2_origin = Point.new(56, metrics[:tree_padding] + correct_root_size.height + metrics[:node_v_margin])
      correct_child2_size = Size.new(15.640625, metrics[:font_point_size] + (metrics[:node_padding] * 2))
      correct_child2_rect = Rect.new(correct_child2_origin, correct_child2_size)
      
      assert_equal correct_root_rect, @root.rect, "The root rect is wrong"
      assert_equal correct_child1_rect, @child1.rect, "The first child's rect is wrong"
      assert_equal correct_child2_rect, @child2.rect, "The second child's rect is wrong"
    end
  end
  
  private
  
  def configure_tree(tree, options)
    font_name = options[:font_name] || SANS_FONT_NAME
    size = options[:size] || :small
    metrics = DEFAULT_METRICS[size]
    
    tree.font_name = font_name
    tree.font_point_size = metrics[:font_point_size]
    tree.tree_padding = metrics[:tree_padding]
    tree.node_h_margin = metrics[:node_h_margin]
    tree.node_v_margin = metrics[:node_v_margin]
    tree.node_padding = metrics[:node_padding]
    
    return tree
  end
end
