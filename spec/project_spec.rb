require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/project.rb'), File.dirname(__FILE__))

class Project
  def targets
    []
  end
end

describe Project do
  describe "given a pbxproj node" do
    before do
      content = File.read(File.expand_path('example_project.pbxproj', File.dirname(__FILE__)))
      project_node = Parser.parse(content)
      project_node.must_be_instance_of Pbxproj::PbxProject
      @project = Project.new(project_node)
    end
    
    describe "project comments" do
    end
    describe "project targets" do
      it "should have the expected targets" do
        @project.targets.count.must_equal 4
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