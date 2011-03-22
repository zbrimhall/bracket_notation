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
  module View # :nodoc:
    class Tree
      attr_accessor :input, :root, :font_name, :font_point_size, :tree_padding, :node_h_margin, :node_v_margin, :node_padding, :color_bg, :color_fg, :color_line, :color_branch, :color_leaf
      
      # Throws :prune, which is caught by #traverse, signaling that method to cease
      # visiting nodes on the current branch.
      def self.prune
        throw(:prune)
      end
      
      def initialize(input)
        @input = input
        @font_name = "Helvetica"
        @font_point_size = 40
        @tree_padding = 20
        @node_h_margin = 50
        @node_v_margin = 30
        @node_padding = 10
        @color_bg = "white"
        @color_fg = "black"
        @color_line = "red"
        @color_branch = "blue"
        @color_leaf = "green"
      end
      
      # Traverse the tree, passing each visited node and the current depth to the
      # given block.
      #
      # Options are:
      # * <tt>:depth</tt> - The starting value of the depth counter. The default is
      #   +0+.
      # * <tt>:order</tt> - The traversal order to follow. Allowed values are:
      #   +:preorder+ (or +:pre+), +:postorder+ (or +:post+), +:breadthfirst+ (or
      #   +:breadth+). The default is +:preorder+.
      # * <tt>:root</tt> - The root node of the subtree to be traversed. The default
      #   is the root node of the entire tree.
      #
      def traverse(options = {}, &block)
        options[:order] ||= :preorder
        options[:depth] ||= 0
        options[:root] ||= @root
        
        return if @root.nil?
        
        if [:breadth, :breadthfirst].include? options[:order]
          node_queue = [options[:root]]
          
          while node = node_queue.shift
            yield node, node.ancestors.length
            node_queue += node.children
          end
        else
          catch(:prune) do
            case options[:order]
              when :pre, :preorder
                yield options[:root], options[:depth]
                options[:root].children.each {|child| traverse({:order => :pre, :root => child, :depth => options[:depth] + 1}, &block) }
              when :post, :postorder
                options[:root].children.each {|child| traverse({:order => :post, :root => child, :depth => options[:depth] + 1}, &block) }
                yield options[:root], options[:depth]
            end
          end
        end
      end
      
      # Computes the node tree layout, setting the correct origin and dimensions
      # for each node.
      def compute_layout
        layout_nodes
        
        old_root_origin_x = @root.rect.origin.x
        new_root_origin_x = ((@root.subtree_size.width + (@tree_padding * 2)) / 2) - (@root.rect.size.width / 2)
        delta = new_root_origin_x - old_root_origin_x
        
        traverse {|node, depth| node.rect = BracketNotation::Geometry::Rect.new(node.rect.origin.point_by_adding_to_x(delta), node.rect.size) }
      end
        
      def inspect
        leaf_content = []
        traverse {|node, depth| leaf_content << node.content if node.kind_of? Leaf }
        return "#{@input} >> \"#{leaf_content.join(" ")}\""
      end
      
      alias :to_s :inspect
      
      def pretty_print
        traverse do |node, depth|
          depth.times { print "--" }
          print " " if depth > 0
          puts node.to_s
        end
      end
      
      private
      
      # Walks the node tree, setting origins and dimensions
      def layout_nodes(node = @root, depth = 0)
        compute_node_dimensions(node)
        compute_node_origin_y(node)
        
        node.children.each {|child| layout_nodes(child, depth + 1) }
        
        compute_subtree_origin_x(node)
      end
      
      def compute_node_dimensions(node)
        background = Magick::Image.new(500, 250)
        gc = Magick::Draw.new
        font = @font_name
        pointsize = @font_point_size
        
        # Write the node content in a scratch image to calculate the text metrics
        gc.annotate(background, 0, 0, 0, 0, node.content) do |gc|
          gc.font = font
          gc.pointsize = pointsize
          gc.gravity = Magick::CenterGravity
          gc.stroke = "none"
        end
        
        metrics = gc.get_type_metrics(background, node.content)
        node.rect = BracketNotation::Geometry::Rect.new(node.rect.origin, BracketNotation::Geometry::Size.new(metrics.width, @font_point_size + (@node_padding * 2)))
      end
      
      def compute_node_origin_y(node)
        adjusted_origin_y = node.parent.nil? ? @tree_padding : node.parent.rect.origin.y + node.parent.rect.size.height + @node_v_margin
        new_origin = BracketNotation::Geometry::Point.new(node.rect.origin.x, adjusted_origin_y)
        node.rect = BracketNotation::Geometry::Rect.new(BracketNotation::Geometry::Point.new(node.rect.origin.x, adjusted_origin_y), node.rect.size)
      end
      
      def compute_subtree_origin_x(node)
        return if node.kind_of? Leaf or node.children.count == 0
        
        node_middle = node.side_middle_top.x
        children_subtree_widths = node.children.collect {|child| child.subtree_size.width}
        max_subtree_width = children_subtree_widths.sort.last
        subtree_width = (max_subtree_width * children_subtree_widths.count) + (@node_h_margin * (node.children.count - 1))
        subtree_origin_x = node_middle - (subtree_width / 2)
        
        node.children.each do |child|
          child_subtree_width = max_subtree_width
          child_node_middle = child.side_middle_top.x
          old_subtree_origin_x = child_node_middle - (child_subtree_width / 2)
          delta = subtree_origin_x - old_subtree_origin_x
          
          traverse(:root => child) {|node, depth| node.rect = BracketNotation::Geometry::Rect.new(node.rect.origin.point_by_adding_to_x(delta), node.rect.size) }
          
          subtree_origin_x += max_subtree_width + @node_h_margin
        end
      end
    end
  end
end
