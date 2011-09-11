require 'minitest/spec'
require 'minitest/autorun'

# require File.expand_path(File.join('..', 'lib/project.rb'), File.dirname(__FILE__))

class Project
  attr_accessor :targets
  
  def initialize(root_node)
    root_dictionary = root_node.pbx_elements.select{|e| e.class == Pbxproj::PbxDictionary}.first
    
    objects = root_dictionary['objects']
    
    @targets = objects.select do |assignment|
      (assignment.value.class == Pbxproj::PbxDictionary) && 
      (assignment.value['is_a'] == "PBXNativeTarget")
    end
    
    @sen_tests = targets.select do |target|
      (assignment.value['productType'].to_s == "com.apple.product-type.bundle") &&
      (assignment.value['productType'].to_s.match /Test/i)
    end
    
    @tests = targets.select do |target|
      (assignment.value['productType'].to_s == "com.apple.product-type.application") &&
      (assignment.value['productType'].to_s.match /Test/i)
    end
    
    @specs = targets.select do |target|
      (assignment.value['productType'].to_s == "com.apple.product-type.application") &&
      (assignment.value['productType'].to_s.match /Spec/i)
    end
  end
  
  def targets
    []
  end
end

describe Project do
  describe "given a pbxproj node" do
    before do
      content = File.read(File.expand_path("fixtures/Valid\ Example\ Project/Valid\ Example\ Project.xcodeproj/project.pbxproj", File.dirname(__FILE__)))
      project_node = Parser.parse(content)
      project_node.must_be_instance_of Pbxproj::PbxProject
      @project = Project.new(project_node)
      
      content = File.read(File.expand_path('example_project.pbxproj', File.dirname(__FILE__)))
      project_node = Parser.parse(content)
      project_node.must_be_instance_of Pbxproj::PbxProject
      @invalid_project = Project.new(project_node)
    end
    
    describe "project comments" do
    end
    describe "project targets" do
      it "should have the expected targets" do
      end
    end
    describe "validation" do
      describe "associating spec targets with the targets they test" do
        describe "find missing resources" do
        end
      end
      describe "associating test targets with the targets they test" do
        describe "find missing resources" do
        end
      end
      describe "associating SenTestKit targets with the targets they test" do
        describe "find redundant resources" do
        end
      end
    end
    describe "resources" do
      describe "groups" do
        describe "list" do
        end
        describe "sort" do
        end
        describe "reorder" do
        end
        describe "add" do
        end
        describe "remove" do
        end
      end
    end
  end
end