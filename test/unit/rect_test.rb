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

class RectTest < Test::Unit::TestCase
  include BracketNotation::Geometry
  
  context "a rect" do
    setup do
      @rect1 = Rect.new
      @rect2 = Rect.new(Point.new(42, 42), Size.new)
      @rect3 = Rect.new(Point.new, Size.new(42, 42))
      @rect4 = Rect.new
    end
    
    should "initiaize to {{0,0},{0,0}}" do
      assert @rect1.origin == Point.new and @rect1.size == Size.new
    end
    
    should "be immutable" do
      assert_raise(NoMethodError) { @rect1.origin = Point.new }
      assert_raise(NoMethodError) { @rect1.size = Size.new }
    end
    
    should "base equality on origin and size" do
      assert_not_equal @rect1, @rect2
      assert_not_equal @rect1, @rect3
      assert_not_equal @rect2, @rect3
      assert_equal @rect1, @rect4
    end
  end
end
