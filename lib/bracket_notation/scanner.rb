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
# Copyright:: Copyright (c) 2010 Cody Brimhall
# License:: Distributed under the terms of the GNU General Public License, v. 3

module BracketNotation # :nodoc:
  # This class represents a scanner for sentences annotated with the kind of
  # bracket notation that is commonly used by linguists. The scanner reads the
  # input string and generates a list of Token instances.
  class Scanner
    include Enumerable
    
    attr_reader :input
    
    UNRESERVED_CHARACTER = /^[^\[\]\s]$/
    LBRACKET_CHARACTER = "["
    RBRACKET_CHARACTER = "]"
    EOL_CHARACTER = nil
    
    # Saves the input string.
    def initialize(input)
      @input = input
      @pos = 0
      @chunk_size = 1
      @last_read = "\n"
      @tokens = nil
    end
    
    # Returns an array of all the tokens produced by the scanner.
    def scan
      return @tokens unless @tokens.nil?
      
      @tokens = []
      token = nil
      @tokens << token while (token = next_token)
      
      return @tokens
    end
    
    # Enumerates the list of tokens, passing each in turn to the provided block.
    def each(&block)
      scan.each &block
    end
    
    private
    
    # Generate and return the next token in the token stream.
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
    
    # Read a single character and update the position pointer.
    def read_char
      return @last_read if @last_read.nil? # Already at end of line
      
      @last_read = input[@pos, @chunk_size]
      @pos += @chunk_size
      
      return @last_read || Token::EOL
    end
    
    # Look ahead to see what the next char will be, without updating @last_read
    # or the position pointer.
    def peek_char
      if @last_read.nil?
        return @last_read
      end
      
      return input[@pos, @chunk_size]
    end
    
    # Gobble up the string of unreserved characters to make a name token.
    def name_token
      value = String.new(@last_read)
      
      # Read through the subsequent unreserved characters to build the name token.
      while(peek_char =~ UNRESERVED_CHARACTER)
        value << read_char
      end
      
      return Token.NAME(value)
    end
    
    # Go back to the beginning of the input string and prepare to generate the.
    # tokens again
    def reset
      @pos = 0
      @last_read = "\n"
    end
  end
end
