require File.join(File.dirname(__FILE__), "..", "test_helper")

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
