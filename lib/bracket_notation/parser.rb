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
    
    # Performs basic validation of a string without executing the entire parse
    # process. Returns true if validation is successful; raises an exception if
    # not.
    def self.validate(input)
      validation_error("parser input cannot be nil") if input.nil?
      validation_error("input string can't be empty") if input.length < 1
      validation_error("all opening brackets must have a label") if /\[\s*\[/ =~ input
      
      # Count the opening and closing brackets to make sure they're balanced
      chars = input.gsub(/[^\[\]]/, "").split(//)
      validation_error("opening and closing brackets must be balanced") if chars.length % 2 != 0
      
      open_count, close_count = 0, 0
      
      chars.each do |char|
        case char
          when '['
            open_count += 1
          when ']'
            close_count += 1
        end
        
        break if open_count < close_count
      end
      
      validation_error("opening and closing brackets must be properly nested") if open_count != close_count
      
      return true
    end
    
    # Saves the input string, as well as a copy of the input string that has
    # been normalized and validated.
    def initialize(input)
      @input = input
      validate
    end
    
    # Scans and evaluates the input string, returning an expression tree.
    def parse
      Evaluator.new(Scanner.new(@input).scan).evaluate
    end
    
    private
    
    # Raises a validation exception with the given message
    def self.validation_error(message)
      raise ValidationError, message
    end
    
    # Performs basic validation of the input string without executing the entire
    # parse process. Returns true if validation is successful; raises an
    # exception if not.
    def validate
      self.class.validate(@input)
    end
  end
end
