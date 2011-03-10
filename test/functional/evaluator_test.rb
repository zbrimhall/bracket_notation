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

require 'test_helper'

class EvaluatorTest < Test::Unit::TestCase
  include BracketNotation
  
  context "the evaluator" do
    setup do
      @tokens = [Token.LBRACKET, Token.NAME("S"), Token.LBRACKET, Token.NAME("DP"), Token.LBRACKET, Token.NAME("D"), Token.NAME("the"), Token.RBRACKET, Token.LBRACKET, Token.NAME("NP"), Token.LBRACKET, Token.NAME("N"), Token.NAME("boy"), Token.RBRACKET, Token.RBRACKET, Token.RBRACKET, Token.LBRACKET, Token.NAME("VP"), Token.LBRACKET, Token.NAME("V"), Token.NAME("ate"), Token.RBRACKET, Token.LBRACKET, Token.NAME("DP"), Token.LBRACKET, Token.NAME("D"), Token.NAME("the"), Token.RBRACKET, Token.LBRACKET, Token.NAME("NP"), Token.LBRACKET, Token.NAME("N"), Token.NAME("bread"), Token.RBRACKET, Token.RBRACKET, Token.RBRACKET, Token.RBRACKET, Token.RBRACKET, Token.EOL]
      @evaluator = Evaluator.new(@tokens)
    end
    
    should "produce an expression" do
      assert_kind_of Expression, @evaluator.evaluate
    end
    
    should "produce a root node" do
      assert_nil @evaluator.evaluate.parent
    end
  end
end
