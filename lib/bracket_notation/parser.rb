module BracketNotation
  class Parser
    attr_reader :input
    
    # Define a custom exception for clearer error reporting
    class ValidationError < RuntimeError; end
    
    def initialize(input)
      validation_error "Parser input cannot be nil" if input.nil?
      
      @input = input
      @data = scrub(input)
      validate
    end
    
    # Scans and evaluates the input string
    def parse
      scanner = Scanner.new(@data)
      evaluator = Evaluator.new(scanner.scan)
      expression = evaluator.evaluate
    end
    
    private
    
    # Clean up the input string to make it easier to parse.
    def scrub(str)
      output = str.gsub(/\t/, "")
      output.gsub!(/\s+/, " ")
      output.gsub!(/\] \[/, "][")
      output.gsub!(/ \[/, "[")
      
      return output
    end
    
    # Check to see if the input is valid, i.e. it has a length, no unnamed nodes,
    # and the bracket-nesting is balanced.
    def validate
      validation_error("Input string can't be empty.") if @data.length < 1
      validation_error("All opening brackets must have a label.") if /\[\s*\[/ =~ @data
      
      # Count the opening and closing brackets to make sure they're balanced
      chars = @data.gsub(/[^\[\]]/, "").split(//)
      validation_error("Opening and closing brackets must be balanced.") if chars.length % 2 != 0
      
      open_count, close_count = 0, 0
      
      chars.each do |char|
        case char
          when '[': open_count += 1
          when ']': close_count += 1
        end
        
        break if open_count < close_count
      end
      
      validation_error("Opening and closing brackets must be properly nested.") if open_count != close_count
    end
    
    # Raise a validation exception with the given message
    def validation_error(message)
      raise ValidationError, message
    end
  end
end
