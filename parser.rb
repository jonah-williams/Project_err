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
      puts tree.to_s
      puts ""
    end
    
    return tree
  end
  
  def self.failure
    "Parse error: #{@@parser.failure_reason}"
  end
end