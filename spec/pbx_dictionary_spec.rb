require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))
require File.expand_path(File.join('..', 'lib/pbxproj_nodes.rb'), File.dirname(__FILE__))

describe Pbxproj::PbxDictionary do
  before do
    content = <<END_PBXPROJ_CONTENT
{
  value /* comment */ = otherValue /* comment */;
  "value with some spaces" = 45;
}
END_PBXPROJ_CONTENT
    
    project_node = Parser.parse(content)
    project_node.must_be_instance_of Pbxproj::PbxProject
    @dictionary_node = project_node.root_dictionary.first
    @dictionary_node.must_be_instance_of Pbxproj::PbxDictionary
  end
  
  describe "keys" do
    it "returns an ordered array of string keys" do
      @dictionary_node.keys.must_equal ["value", "value with some spaces"]
    end
  end
  
  describe "each" do
    it "iterates of the keys and values" do
      keys = []
      value_classes = []
      @dictionary_node.each do |k, v|
        keys << k
        value_classes << v.class
      end
      keys.must_equal ["value", "value with some spaces"]
      values.must_equal [Pbxproj::PbxValue, Pbxproj::PbxValue]
    end
  end
  
  describe "[]" do
    describe "with a valid key" do
      it "returns the value node for the given key" do
        result = @dictionary_node["value"]
        result.must_be_instance_of Pbxproh::PbxValue
        result.to_s.must_equal "otherValue"
      end
    end
    describe "with a non-existant key" do
      it "returns nil" do
        @dictionary_node["unknown key"].must_be_nil
      end
    end
    describe "with the symbol of a valid key" do
      it "returns the value node for the given key" do
        @dictionary_node[:value].to_s.must_equal "otherValue"
      end
    end
  end
  
  describe "length" do
    it "returns the number of keys in the dictionary" do
      @dictionary_node.length.must_equal 2
    end
  end
end