module BracketNotation
  class Expression
    attr_accessor :value, :depth, :parent
    
    def initialize(value, depth = 0)
      @value = value
      @depth = depth
      @parent = nil
    end
    
    def pretty_print
      @depth.times {print "--"}
      puts " #{@value}"
    end
  end
end
