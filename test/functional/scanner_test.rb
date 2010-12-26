require File.join(File.dirname(__FILE__), "..", "test_helper")

class ScannerTest < Test::Unit::TestCase
  include BracketNotation
  
  context "the scanner" do
    setup do
      @input = "[S[DP[D the][NP[N boy]]][VP[V ate][DP[D the][NP[N bread]]]]]"
      @scanner = Scanner.new(@input)
    end
    
    should "always generate at least one token" do
      assert @scanner.scan.length > 0
    end
    
    should "always produce an EOL token as its last token" do
      assert @scanner.scan.last == Token.EOL
    end
  end
end
