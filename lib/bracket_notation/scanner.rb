module BracketNotation
  class Scanner
    include Enumerable
    
    attr_reader :input
    
    UNRESERVED_CHARACTER = /^[^\[\]\s]$/ unless const_defined? :UNRESERVED_CHARACTER
    LBRACKET_CHARACTER = "[" unless const_defined? :LBRACKET_CHARACTER
    RBRACKET_CHARACTER = "]" unless const_defined? :RBRACKET_CHARACTER
    EOL_CHARACTER = nil unless const_defined? :EOL_CHARACTER
    
    def initialize(input)
      @input = input
      @pos = 0
      @chunk_size = 1
      @last_read = "\n"
      @tokens = nil
    end
    
    # Returns an array of all the tokens produced by the scanner
    def scan
      return @tokens unless @tokens.nil?
      
      @tokens = []
      token = nil
      @tokens << token while (token = next_token)
      
      return @tokens
    end
    
    def each(&block)
      scan.each &block
    end
    
    private
    
    # Generate and return the next token in the token stream
    def next_token
      return nil if @last_read.nil?
      
      # Scan the input string for the next token, ignoring white space (and
      # anything else that isn't a recognized character)
      token = nil
      while(token.nil?)
        token = case read_char
          when UNRESERVED_CHARACTER: name_token
          when LBRACKET_CHARACTER: Token.LBRACKET
          when RBRACKET_CHARACTER: Token.RBRACKET
          when EOL_CHARACTER: Token.EOL
          else nil
        end
      end
      
      return token
    end
    
    # Read a single character and update the position pointer
    def read_char
      return @last_read if @last_read.nil? # Already at end of line
      
      @last_read = input[@pos, @chunk_size]
      @pos += @chunk_size
      
      return @last_read || Token::EOL
    end
    
    # Look ahead to see what the next char will be, without updating @last_read
    # or the position pointer
    def peek_char
      if @last_read.nil?
        return @last_read
      end
      
      return input[@pos, @chunk_size]
    end
    
    # Gobble up the string of unreserved characters to make a name token
    def name_token
      value = String.new(@last_read)
      
      # Read through the subsequent unreserved characters to build the name token
      while(peek_char =~ UNRESERVED_CHARACTER)
        value << read_char
      end
      
      return Token.NAME(value)
    end
    
    # Go back to the beginning of the input string and prepare to generate the
    # tokens again
    def reset
      @pos = 0
      @last_read = "\n"
    end
  end
end
