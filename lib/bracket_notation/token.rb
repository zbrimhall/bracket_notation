module BracketNotation
  class Token
    attr_reader :type
    attr_reader :value
    
    # Constants that identify the different types of tokens
    LBRACKET = "LBRACKET"
    RBRACKET = "RBRACKET"
    NAME = "NAME"
    EOL = "EOL"
    
    # Convenience methods for generating new tokens
    def self.LBRACKET; return self.new(LBRACKET); end
    def self.RBRACKET; return self.new(RBRACKET); end
    def self.NAME(value); return self.new(NAME, value); end
    def self.EOL; return self.new(EOL); end
    
    def initialize(type, value = nil)
      @type = type
      @value = value
    end
    
    # Provide a human-friendly string representation of a token instance
    def inspect
      output = "#{@type}"
      output << " \"#{@value}\"" unless @value.nil?
      
      return output
    end
    
    # Two tokens are equal if they are of the same type and have the same value
    def ==(rvalue)
      if self.class != rvalue.class
        return super
      end
      
      return @type == rvalue.type && @value == rvalue.value
    end
  end
end
