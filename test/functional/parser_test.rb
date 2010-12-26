require File.join(File.dirname(__FILE__), "..", "test_helper")

class ParserTest < Test::Unit::TestCase
  include BracketNotation
  
  context "the parser" do
    setup do
      @valid_input = "[S [DP [D the] [NP [N boy]]] [VP [V ate] [DP [D the] [NP [N bread]]]]]"
      @input_with_unnamed_phrase = "[ [DP [D the] [NP [N boy]]] [VP [V ate] [DP [D the] [NP [N bread]]]]]"
      @input_with_too_many_brackets = "[S [DP [D the] [NP [N boy]]] [VP [V ate] [DP [D the] [NP [N bread]]]]]]"
      @input_with_too_few_brackets = "[S [DP [D the] [NP [N boy]]] [VP [V ate] [DP [D the] [NP [N bread]]]]"
      @parser = nil
    end
    
    should "validate good input" do
      assert_nothing_raised do
        @parser = Parser.new(@valid_input)
      end
    end
    
    should "not validate unnamed phrases" do
      assert_raise Parser::ValidationError do
        @parser = Parser.new(@input_with_unnamed_phrase)
      end
    end
    
    should "not validate too many brackets" do
      assert_raise Parser::ValidationError do
        @parser = Parser.new(@input_with_too_many_brackets)
      end
    end
    
    should "not validate too few brackets" do
      assert_raise Parser::ValidationError do
        @parser = Parser.new(@input_with_too_few_brackets)
      end
    end
    
    should "not validate the empty string" do
      assert_raise Parser::ValidationError do
        @parser = Parser.new("")
      end
    end
    
    should "not validate nil" do
      assert_raise Parser::ValidationError do
        @parser = Parser.new(nil)
      end
    end
  end
end
