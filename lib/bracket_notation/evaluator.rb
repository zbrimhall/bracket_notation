module BracketNotation
  class Evaluator
    attr_reader :input
    
    # Define a custom exception for clearer error reporting
    class EvaluationError < SyntaxError; end
    
    def initialize(input)
      @input = input
      @token_index = -1
      @root = nil
    end
    
    # Evaluates a bracketed phrase
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
          when Token::NAME: Terminal.new(token.value)
          when Token::LBRACKET: evaluate_phrase
          else unexpected_token_error
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
    
    # Raises an unexpected token error
    def unexpected_token_error
      raise EvaluationError, "Unexpected token: #{current_token.inspect}"
    end
  end
end
