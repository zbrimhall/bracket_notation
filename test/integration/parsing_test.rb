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

class ParsingTest < Test::Unit::TestCase
  include BracketNotation
  
  context "the parsing process" do
    setup do
      @input = "[S [DP [D the] [NP [N boy]]] [VP [V ate] [DP [D the] [NP [N bread]]]]]"
      @parser = Parser.new(@input)
    end
    
    should "not raise exceptions" do
      assert_nothing_raised do
        @parser.parse
      end
    end
    
    should "produce an expression" do
      assert_kind_of Expression, @parser.parse
    end
  end
end
