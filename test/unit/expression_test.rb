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

class ExpressionTest < Test::Unit::TestCase
  include BracketNotation
  
  context "an identifier expression" do
    setup do
      @identifier1 = Identifier.new("NP", 1)
      @identifier2 = Identifier.new("VP")
    end
    
    should "have a value" do
      assert_not_nil @identifier1.value
    end
    
    should "have a depth" do
      assert_not_nil @identifier1.depth
    end
    
    should "make itself the parent of a new child" do
      @identifier1.add_child(@identifier2)
      assert_same @identifier1, @identifier2.parent
    end
    
    should "update the depth of a new child" do
      @identifier1.add_child(@identifier2)
      assert @identifier2.depth == @identifier1.depth + 1
    end
  end
  
  context "a terminal expression" do
    setup do
      @expression = Terminal.new("NP")
    end
    
    should "have a value" do
      assert_not_nil @expression.value
    end
    
    should "have a depth" do
      assert_not_nil @expression.depth
    end
  end
end
