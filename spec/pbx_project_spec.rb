require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))
require File.expand_path(File.join('..', 'lib/pbxproj_nodes.rb'), File.dirname(__FILE__))

describe Pbxproj::PbxProject do
  describe "project comments" do
    before do
      content = <<END_PBXPROJ_CONTENT
// !$*UTF8*$!
{value /* comment */ = otherValue /* comment */;}
END_PBXPROJ_CONTENT
      @project = Parser.parse(content)
      @project.must_be_instance_of Pbxproj::PbxProject
    end
    it "has the expected comments" do
      @project.comments.length.must_equal 1
      @project.comments.first.must_be_instance_of Pbxproj::PbxEndOfLineComment
      @project.comments.first.to_s.must_equal "// !$*UTF8*$!"
    end
  end
    
  describe "resources" do
    describe "build files" do
      before do
        content = <<END_PBXPROJ_CONTENT
// !$*UTF8*$!
{
  objects = {
    /* Begin PBXBuildFile section */
		8C00F48A141D251000CCAB3D /* UIKit.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F489141D251000CCAB3D /* UIKit.framework */; };
		8C00F48C141D251000CCAB3D /* Foundation.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F48B141D251000CCAB3D /* Foundation.framework */; };
		8C00F48E141D251000CCAB3D /* CoreGraphics.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F48D141D251000CCAB3D /* CoreGraphics.framework */; };
		8C00F494141D251000CCAB3D /* InfoPlist.strings in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F492141D251000CCAB3D /* InfoPlist.strings */; };
		8C00F497141D251000CCAB3D /* main.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F496141D251000CCAB3D /* main.m */; };
		8C00F49A141D251000CCAB3D /* Valid_Example_ProjectAppDelegate.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F499141D251000CCAB3D /* Valid_Example_ProjectAppDelegate.m */; };
		8C00F49D141D251000CCAB3D /* MainWindow.xib in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F49B141D251000CCAB3D /* MainWindow.xib */; };
		8C00F4A0141D251000CCAB3D /* Valid_Example_ProjectViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F49F141D251000CCAB3D /* Valid_Example_ProjectViewController.m */; };
		8C00F4A3141D251000CCAB3D /* Valid_Example_ProjectViewController.xib in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F4A1141D251000CCAB3D /* Valid_Example_ProjectViewController.xib */; };
		8C00F4AA141D251100CCAB3D /* UIKit.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F489141D251000CCAB3D /* UIKit.framework */; };
		8C00F4AB141D251100CCAB3D /* Foundation.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F48B141D251000CCAB3D /* Foundation.framework */; };
		8C00F4AC141D251100CCAB3D /* CoreGraphics.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F48D141D251000CCAB3D /* CoreGraphics.framework */; };
		8C00F4B4141D251100CCAB3D /* InfoPlist.strings in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F4B2141D251100CCAB3D /* InfoPlist.strings */; };
		8C00F4B7141D251100CCAB3D /* Valid_Example_ProjectTests.h in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F4B6141D251100CCAB3D /* Valid_Example_ProjectTests.h */; };
		8C00F4B9141D251100CCAB3D /* Valid_Example_ProjectTests.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4B8141D251100CCAB3D /* Valid_Example_ProjectTests.m */; };
		8C00F4CD141D3DD500CCAB3D /* Valid_Example_ProjectAppDelegate.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F499141D251000CCAB3D /* Valid_Example_ProjectAppDelegate.m */; };
		8C00F4CE141D3DD500CCAB3D /* Valid_Example_ProjectViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F49F141D251000CCAB3D /* Valid_Example_ProjectViewController.m */; };
		8C00F4D0141D3DD500CCAB3D /* UIKit.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F489141D251000CCAB3D /* UIKit.framework */; };
		8C00F4D1141D3DD500CCAB3D /* Foundation.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F48B141D251000CCAB3D /* Foundation.framework */; };
		8C00F4D2141D3DD500CCAB3D /* CoreGraphics.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F48D141D251000CCAB3D /* CoreGraphics.framework */; };
		8C00F4D4141D3DD500CCAB3D /* InfoPlist.strings in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F492141D251000CCAB3D /* InfoPlist.strings */; };
		8C00F4D5141D3DD500CCAB3D /* MainWindow.xib in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F49B141D251000CCAB3D /* MainWindow.xib */; };
		8C00F4D6141D3DD500CCAB3D /* Valid_Example_ProjectViewController.xib in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F4A1141D251000CCAB3D /* Valid_Example_ProjectViewController.xib */; };
		8C00F4E0141D3DFA00CCAB3D /* Valid_Example_ProjectAppDelegate.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F499141D251000CCAB3D /* Valid_Example_ProjectAppDelegate.m */; };
		8C00F4E1141D3DFA00CCAB3D /* Valid_Example_ProjectViewController.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F49F141D251000CCAB3D /* Valid_Example_ProjectViewController.m */; };
		8C00F4E3141D3DFA00CCAB3D /* UIKit.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F489141D251000CCAB3D /* UIKit.framework */; };
		8C00F4E4141D3DFA00CCAB3D /* Foundation.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F48B141D251000CCAB3D /* Foundation.framework */; };
		8C00F4E5141D3DFA00CCAB3D /* CoreGraphics.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 8C00F48D141D251000CCAB3D /* CoreGraphics.framework */; };
		8C00F4E7141D3DFA00CCAB3D /* InfoPlist.strings in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F492141D251000CCAB3D /* InfoPlist.strings */; };
		8C00F4E8141D3DFA00CCAB3D /* MainWindow.xib in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F49B141D251000CCAB3D /* MainWindow.xib */; };
		8C00F4E9141D3DFA00CCAB3D /* Valid_Example_ProjectViewController.xib in Resources */ = {isa = PBXBuildFile; fileRef = 8C00F4A1141D251000CCAB3D /* Valid_Example_ProjectViewController.xib */; };
		8C00F4F2141D3E3E00CCAB3D /* main.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F1141D3E3E00CCAB3D /* main.m */; };
		8C00F4F4141D3E4F00CCAB3D /* main.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F3141D3E4F00CCAB3D /* main.m */; };
		8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F5141D3E8400CCAB3D /* ExampleSpec.m */; };
		8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */; };
/* End PBXBuildFile section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      
      it "lists the build files" do
        @project.build_files.length.must_equal 34
      end
    end
    
    describe "container item proxies" do
    end
    
    describe "file references" do
    end
    
    describe "framework build phases" do
    end
    
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
  
    describe "native targets" do
      before do
        content = <<END_PBXPROJ_CONTENT
// !$*UTF8*$!
{
  objects = {
    /* Begin PBXNativeTarget section */
		1D6058900D05DD3D006BFB54 /* App Target */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 1D6058960D05DD3E006BFB54 /* Build configuration list for PBXNativeTarget "App Target" */;
			buildPhases = (
				1D60588D0D05DD3D006BFB54 /* Resources */,
				1D60588E0D05DD3D006BFB54 /* Sources */,
				1D60588F0D05DD3D006BFB54 /* Frameworks */,
			);
			buildRules = (
			);
			dependencies = (
				506EE1A81030507B00A389B3 /* PBXTargetDependency */,
				93531FBC12E1502C00FE8499 /* PBXTargetDependency */,
			);
			name = "App Target";
			productName = "My App";
			productReference = 1D6058910D05DD3D006BFB54 /* My App.app */;
			productType = "com.apple.product-type.application";
		};
		506EE05D10304ED200A389B3 /* cocos2d libraries */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 506EE06410304F0100A389B3 /* Build configuration list for PBXNativeTarget "cocos2d libraries" */;
			buildPhases = (
				506EE05A10304ED200A389B3 /* Headers */,
				506EE05B10304ED200A389B3 /* Sources */,
				506EE05C10304ED200A389B3 /* Frameworks */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = "cocos2d libraries";
			productName = "cocos2d libraries";
			productReference = DA31A42312DCA7BD00CDC1C4 /* libcocos2d libraries.a */;
			productType = "com.apple.product-type.library.static";
		};
		8C42515813F5CBE6004A6E72 /* App Target Specs */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 8C4255A213F5CBE6004A6E72 /* Build configuration list for PBXNativeTarget "App Target Specs" */;
			buildPhases = (
				8C4254C813F5CBE6004A6E72 /* Sources */,
				8C42559513F5CBE6004A6E72 /* Frameworks */,
			);
			buildRules = (
			);
			dependencies = (
				8C42515913F5CBE6004A6E72 /* PBXTargetDependency */,
				8C42515B13F5CBE6004A6E72 /* PBXTargetDependency */,
			);
			name = "App Target Specs";
			productName = "App Target";
			productReference = 8C4255A613F5CBE6004A6E72 /* App Target Specs.app */;
			productType = "com.apple.product-type.application";
		};
    /* End PBXNativeTarget section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      it "should have the expected targets" do
        @project.targets.length.must_equal 3
        @project.targets.each do |target|
          target.must_be_instance_of Pbxproj::PbxTarget
        end
      end
    end

    describe "project settings" do
    end

    describe "resources build phases" do
    end

    describe "shell script build phases" do
    end

    describe "sources build phases" do
    end

    describe "target dependencies" do
    end

    describe "variant groups" do
    end

    describe "build configurations" do
    end

    describe "configuration lists" do
    end
  end
  
  describe "top level attributes" do
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
end