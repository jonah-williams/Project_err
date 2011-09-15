require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))
require File.expand_path(File.join('..', 'lib/pbxproj_validator.rb'), File.dirname(__FILE__))

describe Pbxproj::PbxProject do
  describe "printing" do
    before do
      content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
  /* Begin PBXContainerItemProxy section */
  	8C00F4AD141D251100CCAB3D /* PBXContainerItemProxy */ = {
  		isa = PBXContainerItemProxy;
  		containerPortal = 8C00F47C141D251000CCAB3D /* Project object */;
  		proxyType = 1;
  		remoteGlobalIDString = 8C00F484141D251000CCAB3D;
  		remoteInfo = "Valid Example Project";
  	};
  /* End PBXContainerItemProxy section */
  };
}
END_PBXPROJ_CONTENT
      @project = Parser.parse(content)
      @project.must_be_instance_of Pbxproj::PbxProject
    end
    it "can print the project" do
      @project.print.wont_be_nil
    end
  end
  
  describe "validation" do
    describe "inspecting app targets" do
      describe "find redundant resources" do
        it "identifies the redundant resources" do
          skip "PENDING"
        end
      end
      describe "find missing resources" do
        it "identifies the missing resources" do
          skip "PENDING"
        end
      end
    end
    describe "associating spec targets with the targets they test" do
      describe "find missing resources" do
        it "identifies missing specs" do
          skip "PENDING"
        end
        it "identifies missing classes" do
          skip "PENDING"
        end
        it "identifies missing resources" do
          skip "PENDING"
        end
      end
      describe "find redundant resources" do
        it "identifies the redundant resources" do
          skip "PENDING"
        end
      end
    end
    describe "associating test targets with the targets they test" do
      describe "find missing resources" do
        it "identifies the missing resources" do
          skip "PENDING"
        end
      end
      describe "find redundant resources" do
        it "identifies the redundant resources" do
          skip "PENDING"
        end
      end
    end
    describe "associating SenTestKit targets with the targets they test" do
      describe "find redundant resources" do
        it "identifies the redundant resources" do
          skip "PENDING"
        end
      end
    end
  end
end