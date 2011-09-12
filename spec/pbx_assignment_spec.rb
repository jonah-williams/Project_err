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
    @assignment_node = project_node.root_dictionary.pbx_elements.first
    @assignment_node.must_be_instance_of Pbxproj::PbxAssignment
  end
  
  describe "variable" do
    it "returns the variable updated by the assignment" do
      @assignment_node.variable.must_be_instance_of Pbxproj::PbxValue
      @assignment_node.variable.to_s.must_equal "value"
    end
  end
  
  describe "assigned_value" do
    it "returns the value given by the assignment" do
      @assignment_node.assigned_value.must_be_instance_of Pbxproj::PbxValue
      @assignment_node.assigned_value.to_s.must_equal "otherValue"
    end
  end
end