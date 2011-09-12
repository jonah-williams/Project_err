require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))
require File.expand_path(File.join('..', 'lib/pbxproj_nodes.rb'), File.dirname(__FILE__))

describe Pbxproj::PbxArray do
  before do
    content = <<END_PBXPROJ_CONTENT
{
  buildConfigurations = (
    C01FCF4F08A954540054247B /* Debug */,
    C01FCF5008A954540054247B /* Release */,
    E22E41D81281F13F006A09EA /* Distribution */,
  );
}
END_PBXPROJ_CONTENT
    
    project_node = Parser.parse(content)
    project_node.must_be_instance_of Pbxproj::PbxProject
    @array_node = project_node.root_dictionary[:buildConfigurations]
    @array_node.must_be_instance_of Pbxproj::PbxArray
  end
  
  describe "[]" do
    describe "given an index with the array's bounds" do
      it "returns the node at that index" do
        result = @array_node[1]
        result.must_be_instance_of Pbxproj::PbxValue
        result.to_s.must_equal "C01FCF5008A954540054247B"
      end
    end
    describe "given a negative index" do
      it "indexes from the end of the array" do
        result = @array_node[-1]
        result.must_be_instance_of Pbxproj::PbxValue
        result.to_s.must_equal "E22E41D81281F13F006A09EA"
      end
    end
    describe "given an index greater than the array's size" do
      it "returns nil" do
        @array_node[@array_node.length + 1].must_be_nil
      end
    end
    describe "given a negative index greater than the array's size" do
      it "returns nil" do
        @array_node[-1 * (@array_node.length + 1)].must_be_nil
      end
    end
  end
  
  describe "each" do
    it "iterates over the contents of the array" do
      content_values = []
      content_classes = []
      @array_node.each do |element|
        content_values << element.value
        content_classes << element.class
      end
      content_values.must_equal ["C01FCF4F08A954540054247B", "C01FCF5008A954540054247B", "E22E41D81281F13F006A09EA"]
      content_classes.must_equal [Pbxproj::PbxValue, Pbxproj::PbxValue, Pbxproj::PbxValue]
    end
  end
  
  describe "length" do
    it "returns the length of the array" do
      @array_node.length.must_equal 3
    end
  end
end