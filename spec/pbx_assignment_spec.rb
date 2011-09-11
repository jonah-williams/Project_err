require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))
require File.expand_path(File.join('..', 'lib/pbxproj_nodes.rb'), File.dirname(__FILE__))

describe Pbxproj::PbxAssignment do
  before do
    content = <<END_PBXPROJ_CONTENT
{value /* comment */ = otherValue /* comment */;}
END_PBXPROJ_CONTENT
    
    project_node = Parser.parse(content)
    project_node.must_be_instance_of Pbxproj::PbxProject
    @assignment_node = project_node.comments.first
  end  
end