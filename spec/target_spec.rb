require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/target.rb'), File.dirname(__FILE__))

class Target
end

describe Target do
  describe "given a PbxDictionary for a target" do
    describe "validation" do
      describe "check for duplicate resources" do
      end
      describe "check for built headers" do
      end
      describe "check for unknown resources" do
      end
      describe "check for redundant search paths" do
      end
    end
    
    describe "resources" do
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
    
    describe "sources" do
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
    
    describe "build settings" do
      describe "add library" do
      end
      describe "linker flags" do
        describe "list" do
        end
        describe "add" do
        end
        describe "remove" do
        end
      end
    end
  end
end