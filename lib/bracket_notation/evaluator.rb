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
# Copyright:: Copyright (c) 2010-2011 Cody Brimhall
# License:: Distributed under the terms of the GNU General Public License, v. 3

module BracketNotation # :nodoc:
  # This class takes a list of Token instances and evaluates them. The result is
  # an abstract tree representation of the syntax of the original string fed to
  # the parser.
  class Evaluator
    attr_reader :input
    
    # This class is an Exception subclass that reports errors in the evaluation
    # process.
    class EvaluationError < SyntaxError; end
    
    # Saves the token list for evaluation.
    def initialize(input)
      @input = input
      @token_index = -1
      @root = nil
    end
    
    # Evaluates a bracketed phrase and returns the Evaluation instance that
    # represents the phrase.
    def evaluate
      return @root unless @root.nil?
      
      token = next_token
      unexpected_token_error if token.type != Token::LBRACKET
      @root = evaluate_phrase
      
      unexpected_token_error if next_token.type != Token::EOL
      
      return @root
    end
    
    private
    
    # Evaluates a phrase expression.
    def evaluate_phrase
      token = next_token
      unexpected_token_error if token.type != Token::NAME
      
      identifier = Identifier.new(token.value)
      
      while((token = next_token).type != Token::RBRACKET)
        expression = case token.type
          when Token::NAME
            Terminal.new(token.value)
          when Token::LBRACKET
            evaluate_phrase
          else
            unexpected_token_error
        end
        
        identifier.add_child(expression)
      end
      
      return identifier
    end
    
    # Returns the token currently being evaluated.
    def current_token
      return @input[@token_index]
    end
    
    # Advances the token index and returns the new current token.
    def next_token
      @token_index += 1
      return current_token
    end
    
    # Raises an unexpected token error.
    def unexpected_token_error
      raise EvaluationError, "Unexpected token: #{current_token.inspect}"
    end
  end
end

