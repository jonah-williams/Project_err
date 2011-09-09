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
    puts "#{' '*indentation} #{root_node}"
    root_node.pbx_elements.each do |node| 
      self.print_tree(node, indentation + 1)
    end
  end
end