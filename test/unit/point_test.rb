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

class PointTest < Test::Unit::TestCase
  include BracketNotation::Geometry
  
  context "a point" do
    setup do
      @point1 = Point.new
      @point2 = Point.new(42, 42)
      @point3 = Point.new(42, 42)
      @point4 = Point.new(42, 0)
      @point5 = Point.new(0, 42)
    end
    
    should "initiaize to {0,0}" do
      assert @point1.x == 0 and @point1.y == 0
    end
    
    should "be immutable" do
      assert_raise(NoMethodError) { @point1.x = 0 }
      assert_raise(NoMethodError) { @point1.y = 0 }
    end
    
    should "base equality on coordinates" do
      assert_not_equal @point1, @point2
      assert_equal @point2, @point3
    end
    
    should "create new point by adding to X" do
      assert_equal @point1.point_by_adding_to_x(42), @point4
    end
    
    should "create new point by adding to y" do
      assert_equal @point1.point_by_adding_to_y(42), @point5
    end
    
    should "create new point by adding to x and y" do
      assert_equal @point1.point_by_adding_to_x_and_y(42, 42), @point2
    end
  end
end
