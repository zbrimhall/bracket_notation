require File.join(File.dirname(__FILE__), "..", "test_helper")

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
