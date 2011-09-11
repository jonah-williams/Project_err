require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))
require File.expand_path(File.join('..', 'lib/pbxproj_nodes.rb'), File.dirname(__FILE__))

describe Pbxproj::PbxEndOfLineComment do
  before do
    content = <<END_PBXPROJ_CONTENT
// !$*UTF8*$! /* file header */
//
END_PBXPROJ_CONTENT
    
    project_node = Parser.parse(content)
    project_node.must_be_instance_of Pbxproj::PbxProject
    @comment_node = project_node.comments.first
  end
  
  it "has a string representation" do
    @comment_node.to_s.must_equal '// !$*UTF8*$! /* file header */'
  end
end
