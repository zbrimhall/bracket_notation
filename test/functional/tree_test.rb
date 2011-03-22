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

class TreeTest < Test::Unit::TestCase
  include BracketNotation::View
  
  context "a tree" do
    setup do
      @tree = Tree.new("[A [B [E] [F]] [C] [D]]")
      @root = Node.new(@tree, "A")
      @child1 = Node.new(@tree, "B")
      @child2 = Node.new(@tree, "C")
      @child3 = Node.new(@tree, "D")
      @child4 = Node.new(@tree, "E")
      @child5 = Node.new(@tree, "F")
      
      @child1.children += [@child4, @child5]
      @root.children += [@child1, @child2, @child3]
      @tree.root = @root
    end
    
    should "traverse preorder" do
      buffer = ""
      @tree.traverse(:order => :preorder) {|node, depth| buffer << node.content }
      assert_equal buffer, "ABEFCD"
    end
    
    should "traverse postorder" do
      buffer = ""
      @tree.traverse(:order => :postorder) {|node, depth| buffer << node.content }
      assert_equal buffer, "EFBCDA"
    end
    
    should "traverse breadthfirst" do
      buffer = ""
      @tree.traverse(:order => :breadthfirst) {|node, depth| buffer << node.content }
      assert_equal buffer, "ABCDEF"
    end
  end
end
