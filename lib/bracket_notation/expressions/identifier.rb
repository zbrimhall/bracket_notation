module BracketNotation
  class Identifier < Expression
    attr_accessor :children
    
    def initialize(value, depth = 0)
      super
      @children = []
    end
    
    # Adds the given expression to the children array and updates the new child's
    # parent and depth attributes.
    def add_child(expression)
      expression.parent = self
      expression.depth = @depth + 1
      @children << expression
    end
    
    # Sets the new depth, and the new depth of all children.
    def depth=(rvalue)
      @depth = rvalue
      children.each {|child| child.depth = rvalue + 1}
    end
    
    def pretty_print
      super
      @children.each {|child| child.pretty_print}
    end
  end
end
