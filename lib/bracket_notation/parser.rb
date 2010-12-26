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
  # This class represents a parser for sentences annotated with the kind of
  # bracket notation that is commonly used by linguists. After being checked for
  # obvious problems, the input string is scanned for tokens, which are
  # evaluated to produce an expression tree.
  class Parser
    attr_reader :input
    
    # This class is an Exception subclass that reports errors in the input
    # validation process.
    class ValidationError < RuntimeError; end
    
    # Saves the input string, as well as a copy of the input string that has
    # been normalized and validated.
    def initialize(input)
      validation_error "Parser input cannot be nil" if input.nil?
      
      @input = input
      @data = scrub(input)
      validate
    end
    
    # Scans and evaluates the input string, returning an expression tree.
    def parse
      scanner = Scanner.new(@data)
      evaluator = Evaluator.new(scanner.scan)
      expression = evaluator.evaluate
    end
    
    private
    
    # Normalizes the input string to make it easier to parse.
    def scrub(str)
      output = str.gsub(/\t/, "")
      output.gsub!(/\s+/, " ")
      output.gsub!(/\] \[/, "][")
      output.gsub!(/ \[/, "[")
      
      return output
    end
    
    # Checks to see if the input is valid, i.e. it has a length, no unnamed
    # nodes, and the bracket-nesting is balanced.
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
    
    # Raises a validation exception with the given message
    def validation_error(message)
      raise ValidationError, message
    end
  end
end
