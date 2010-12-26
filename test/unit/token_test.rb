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

require 'test/test_helper'

class TokenTest < Test::Unit::TestCase
  include BracketNotation
  
  context "a left bracket token" do
    setup do
      @lbracket = Token.LBRACKET
    end
    
    should "be of type #{Token::LBRACKET}" do
      assert_equal Token::LBRACKET, @lbracket.type
    end
    
    should "not have a value" do
      assert_nil @lbracket.value
    end
  end
  
  context "a right bracket token" do
    setup do
      @rbracket = Token.RBRACKET
    end
    
    should "be of type #{Token::RBRACKET}" do
      assert_equal Token::RBRACKET, @rbracket.type
    end
    
    should "not have a value" do
      assert_nil @rbracket.value
    end
  end
  
  context "a name token" do
    setup do
      @value = "string"
      @name = Token.NAME(@value)
    end
    
    should "be of type #{Token::NAME}" do
      assert_equal Token::NAME, @name.type
    end
    
    should "have a value" do
      assert_not_nil @name.value
    end
    
    should "have a value equal to that which was given when initializing" do
      assert_equal @value, @name.value
    end
  end
  
  context "an end-of-line token" do
    setup do
      @eol = Token.EOL
    end
    
    should "be of type #{Token::EOL}" do
      assert_equal Token::EOL, @eol.type
    end
    
    should "not have a value" do
      assert_nil @eol.value
    end
  end
  
  context "two tokens" do
    setup do
      @name1 = Token.NAME("name")
      @name2 = Token.NAME("name")
      @name3 = Token.NAME("other")
      @bracket = Token.LBRACKET
      @eol = Token.EOL
    end
    
    should "be equal if they have the same type and value" do
      assert_equal @name1, @name2
      assert_equal @bracket1, @bracket2
    end
    
    should "be unequal if they have different types" do
      assert_not_equal @bracket, @eol
    end
    
    should "be unequal if they have different values" do
      assert_not_equal @name1, @name3
    end
  end
end
