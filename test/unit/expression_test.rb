require File.join(File.dirname(__FILE__), "..", "test_helper")

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
