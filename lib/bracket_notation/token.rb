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
  # This class represents a token in a stream of characters. All tokens have a
  # type, and some of them (e.g. +NAME+ tokens) have corresponding values.
  class Token
    attr_reader :type
    attr_reader :value
    
    # Constants that identify the different types of tokens
    LBRACKET = "LBRACKET"
    RBRACKET = "RBRACKET"
    NAME = "NAME"
    EOL = "EOL"
    
    # Initializes and returns a new token of type +LBRACKET+.
    def self.LBRACKET; return self.new(LBRACKET); end
    
    # Initializes and returns a new token of type +RBRACKET+.
    def self.RBRACKET; return self.new(RBRACKET); end
    
    # Initializes and returns a new token of type +NAME+.
    def self.NAME(value); return self.new(NAME, value); end
    
    # Initializes and returns a new token of type +EOL+.
    def self.EOL; return self.new(EOL); end
    
    # Saves the token type, as well as an optional value.
    def initialize(type, value = nil)
      @type = type
      @value = value
    end
    
    # Provides a human-friendly string representation of a token instance.
    def inspect # :nodoc:
      output = "#{@type}"
      output << " \"#{@value}\"" unless @value.nil?
      
      return output
    end
    
    # Compares the receiver with another object, returning true only if the
    # other object is also an instance of Token, and only if the two tokens
    # share the same +type+ and +value+.
    def ==(rvalue)
      if self.class != rvalue.class
        return super
      end
      
      return @type == rvalue.type && @value == rvalue.value
    end
  end
end
