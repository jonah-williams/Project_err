require 'polyglot'
require 'treetop'

require File.expand_path(File.join(File.dirname(__FILE__), 'pbxproj_nodes.rb'))

class Parser
  
  Treetop.load(File.expand_path(File.join(File.dirname(__FILE__), 'pbxproj.treetop')))
  @@parser = PbxprojParser.new
  
  Treetop.load('pbxproj.treetop')
  
  def self.parse(data)
    tree = @@parser.parse(data)
    
    if tree
      self.print_tree(tree)
      puts ""
    end
    
    return tree
  end
  
  def self.failure
    "Parse error: #{@@parser.failure_reason}"
  end
  
  private
  
  def self.print_tree(root_node, indentation = 0)
    return if(root_node.elements.nil?)
    unless (root_node.class.name == "Treetop::Runtime::SyntaxNode")
      tv = root_node.description
      tv = "...#{tv[-40..-1]}" if tv.size > 40
      puts "#{' '*indentation} #{tv}"
    end
    root_node.elements.each do |node| 
      next_indentation = indentation
      unless (node.class.name == "Treetop::Runtime::SyntaxNode")
        next_indentation = indentation + 1
      end
      self.print_tree(node, next_indentation)
    end
  end
end