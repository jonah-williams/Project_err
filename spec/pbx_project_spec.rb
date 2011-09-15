require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))
require File.expand_path(File.join('..', 'lib/pbxproj_nodes.rb'), File.dirname(__FILE__))

describe Pbxproj::PbxProject do
  describe "project comments" do
    before do
      content = <<'END_PBXPROJ_CONTENT'
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
        content = <<'END_PBXPROJ_CONTENT'
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
        @project.build_files.length.must_equal 35
      end
    end
    
    describe "container item proxies" do
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
      
      it "lists the container item proxies" do
        @project.container_item_proxies.length.must_equal 1
      end
    end
    
    describe "file references" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
/* Begin PBXFileReference section */
		8C00F485141D251000CCAB3D /* Valid Example Project.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "Valid Example Project.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		8C00F489141D251000CCAB3D /* UIKit.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = UIKit.framework; path = System/Library/Frameworks/UIKit.framework; sourceTree = SDKROOT; };
		8C00F48B141D251000CCAB3D /* Foundation.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = Foundation.framework; path = System/Library/Frameworks/Foundation.framework; sourceTree = SDKROOT; };
		8C00F48D141D251000CCAB3D /* CoreGraphics.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = CoreGraphics.framework; path = System/Library/Frameworks/CoreGraphics.framework; sourceTree = SDKROOT; };
		8C00F491141D251000CCAB3D /* Valid Example Project-Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = "Valid Example Project-Info.plist"; sourceTree = "<group>"; };
		8C00F493141D251000CCAB3D /* en */ = {isa = PBXFileReference; lastKnownFileType = text.plist.strings; name = en; path = en.lproj/InfoPlist.strings; sourceTree = "<group>"; };
		8C00F495141D251000CCAB3D /* Valid Example Project-Prefix.pch */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = "Valid Example Project-Prefix.pch"; sourceTree = "<group>"; };
		8C00F496141D251000CCAB3D /* main.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = main.m; sourceTree = "<group>"; };
		8C00F498141D251000CCAB3D /* Valid_Example_ProjectAppDelegate.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = Valid_Example_ProjectAppDelegate.h; sourceTree = "<group>"; };
		8C00F499141D251000CCAB3D /* Valid_Example_ProjectAppDelegate.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = Valid_Example_ProjectAppDelegate.m; sourceTree = "<group>"; };
		8C00F49C141D251000CCAB3D /* en */ = {isa = PBXFileReference; lastKnownFileType = file.xib; name = en; path = en.lproj/MainWindow.xib; sourceTree = "<group>"; };
		8C00F49E141D251000CCAB3D /* Valid_Example_ProjectViewController.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = Valid_Example_ProjectViewController.h; sourceTree = "<group>"; };
		8C00F49F141D251000CCAB3D /* Valid_Example_ProjectViewController.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = Valid_Example_ProjectViewController.m; sourceTree = "<group>"; };
		8C00F4A2141D251000CCAB3D /* en */ = {isa = PBXFileReference; lastKnownFileType = file.xib; name = en; path = en.lproj/Valid_Example_ProjectViewController.xib; sourceTree = "<group>"; };
		8C00F4A9141D251100CCAB3D /* Valid Example ProjectTests.octest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "Valid Example ProjectTests.octest"; sourceTree = BUILT_PRODUCTS_DIR; };
		8C00F4B1141D251100CCAB3D /* Valid Example ProjectTests-Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = "Valid Example ProjectTests-Info.plist"; sourceTree = "<group>"; };
		8C00F4B3141D251100CCAB3D /* en */ = {isa = PBXFileReference; lastKnownFileType = text.plist.strings; name = en; path = en.lproj/InfoPlist.strings; sourceTree = "<group>"; };
		8C00F4B5141D251100CCAB3D /* Valid Example ProjectTests-Prefix.pch */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = "Valid Example ProjectTests-Prefix.pch"; sourceTree = "<group>"; };
		8C00F4B6141D251100CCAB3D /* Valid_Example_ProjectTests.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = Valid_Example_ProjectTests.h; sourceTree = "<group>"; };
		8C00F4B8141D251100CCAB3D /* Valid_Example_ProjectTests.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = Valid_Example_ProjectTests.m; sourceTree = "<group>"; };
		8C00F4DA141D3DD500CCAB3D /* Valid Example Project copy.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "Valid Example Project copy.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		8C00F4ED141D3DFA00CCAB3D /* Valid Example Project copy.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "Valid Example Project copy.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		8C00F4F1141D3E3E00CCAB3D /* main.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; name = main.m; path = Tests/main.m; sourceTree = "<group>"; };
		8C00F4F3141D3E4F00CCAB3D /* main.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; name = main.m; path = Specs/main.m; sourceTree = "<group>"; };
		8C00F4F5141D3E8400CCAB3D /* ExampleSpec.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; name = ExampleSpec.m; path = Specs/ExampleSpec.m; sourceTree = "<group>"; };
		8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; name = ExampleTest.m; path = Tests/ExampleTest.m; sourceTree = "<group>"; };
/* End PBXFileReference section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      
      it "lists the file references" do
        @project.file_references.length.must_equal 26
      end
    end
    
    describe "framework build phases" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
/* Begin PBXFrameworksBuildPhase section */
  	8C00F482141D251000CCAB3D /* Frameworks */ = {
  		isa = PBXFrameworksBuildPhase;
  		buildActionMask = 2147483647;
  		files = (
  			8C00F48A141D251000CCAB3D /* UIKit.framework in Frameworks */,
  			8C00F48C141D251000CCAB3D /* Foundation.framework in Frameworks */,
  			8C00F48E141D251000CCAB3D /* CoreGraphics.framework in Frameworks */,
  		);
  		runOnlyForDeploymentPostprocessing = 0;
  	};
  	8C00F4A5141D251100CCAB3D /* Frameworks */ = {
  		isa = PBXFrameworksBuildPhase;
  		buildActionMask = 2147483647;
  		files = (
  			8C00F4AA141D251100CCAB3D /* UIKit.framework in Frameworks */,
  			8C00F4AB141D251100CCAB3D /* Foundation.framework in Frameworks */,
  			8C00F4AC141D251100CCAB3D /* CoreGraphics.framework in Frameworks */,
  		);
  		runOnlyForDeploymentPostprocessing = 0;
  	};
  	8C00F4CF141D3DD500CCAB3D /* Frameworks */ = {
  		isa = PBXFrameworksBuildPhase;
  		buildActionMask = 2147483647;
  		files = (
  			8C00F4D0141D3DD500CCAB3D /* UIKit.framework in Frameworks */,
  			8C00F4D1141D3DD500CCAB3D /* Foundation.framework in Frameworks */,
  			8C00F4D2141D3DD500CCAB3D /* CoreGraphics.framework in Frameworks */,
  		);
  		runOnlyForDeploymentPostprocessing = 0;
  	};
  	8C00F4E2141D3DFA00CCAB3D /* Frameworks */ = {
  		isa = PBXFrameworksBuildPhase;
  		buildActionMask = 2147483647;
  		files = (
  			8C00F4E3141D3DFA00CCAB3D /* UIKit.framework in Frameworks */,
  			8C00F4E4141D3DFA00CCAB3D /* Foundation.framework in Frameworks */,
  			8C00F4E5141D3DFA00CCAB3D /* CoreGraphics.framework in Frameworks */,
  		);
  		runOnlyForDeploymentPostprocessing = 0;
  	};
  /* End PBXFrameworksBuildPhase section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      
      it "lists the framework build phases" do
        @project.framework_build_phases.length.must_equal 4
      end
    end
    
    describe "groups" do
      describe "list" do
        it "lists groups" do
          skip "PENDING"
        end
      end
      describe "sort" do
        it "sorts groups" do
          skip "PENDING"
        end
      end
    end
  
    describe "native targets" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
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

    describe "project section" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
    /* Begin PBXProject section */
  	8C00F47C141D251000CCAB3D /* Project object */ = {
  		isa = PBXProject;
  		attributes = {
  			ORGANIZATIONNAME = "Carbon Five";
  		};
  		buildConfigurationList = 8C00F47F141D251000CCAB3D /* Build configuration list for PBXProject "Valid Example Project" */;
  		compatibilityVersion = "Xcode 3.2";
  		developmentRegion = English;
  		hasScannedForEncodings = 0;
  		knownRegions = (
  			en,
  		);
  		mainGroup = 8C00F47A141D251000CCAB3D;
  		productRefGroup = 8C00F486141D251000CCAB3D /* Products */;
  		projectDirPath = "";
  		projectRoot = "";
  		targets = (
  			8C00F484141D251000CCAB3D /* Valid Example Project */,
  			8C00F4A8141D251100CCAB3D /* Valid Example ProjectTests */,
  			8C00F4CA141D3DD500CCAB3D /* Valid Example Project Tests */,
  			8C00F4DD141D3DFA00CCAB3D /* Valid Example Project Specs */,
  		);
  	};
    /* End PBXProject section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
    end

    describe "resources build phases" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
/* Begin PBXResourcesBuildPhase section */
		8C00F483141D251000CCAB3D /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				8C00F494141D251000CCAB3D /* InfoPlist.strings in Resources */,
				8C00F49D141D251000CCAB3D /* MainWindow.xib in Resources */,
				8C00F4A3141D251000CCAB3D /* Valid_Example_ProjectViewController.xib in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		8C00F4A6141D251100CCAB3D /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				8C00F4B4141D251100CCAB3D /* InfoPlist.strings in Resources */,
				8C00F4B7141D251100CCAB3D /* Valid_Example_ProjectTests.h in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		8C00F4D3141D3DD500CCAB3D /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				8C00F4D4141D3DD500CCAB3D /* InfoPlist.strings in Resources */,
				8C00F4D5141D3DD500CCAB3D /* MainWindow.xib in Resources */,
				8C00F4D6141D3DD500CCAB3D /* Valid_Example_ProjectViewController.xib in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		8C00F4E6141D3DFA00CCAB3D /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				8C00F4E7141D3DFA00CCAB3D /* InfoPlist.strings in Resources */,
				8C00F4E8141D3DFA00CCAB3D /* MainWindow.xib in Resources */,
				8C00F4E9141D3DFA00CCAB3D /* Valid_Example_ProjectViewController.xib in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      
      it "should have the expected build phases" do
        @project.resources_build_phases.length.must_equal 4
      end
    end

    describe "shell script build phases" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
/* Begin PBXShellScriptBuildPhase section */
		8C00F4A7141D251100CCAB3D /* ShellScript */ = {
			isa = PBXShellScriptBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			inputPaths = (
			);
			outputPaths = (
			);
			runOnlyForDeploymentPostprocessing = 0;
			shellPath = /bin/sh;
			shellScript = "# Run the unit tests in this test bundle.\n\"${SYSTEM_DEVELOPER_DIR}/Tools/RunUnitTests\"\n";
		};
/* End PBXShellScriptBuildPhase section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      
      it "should have the expected build phases" do
        @project.shell_script_build_phases.length.must_equal 1
      end
    end

    describe "sources build phases" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
/* Begin PBXSourcesBuildPhase section */
		8C00F481141D251000CCAB3D /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				8C00F497141D251000CCAB3D /* main.m in Sources */,
				8C00F49A141D251000CCAB3D /* Valid_Example_ProjectAppDelegate.m in Sources */,
				8C00F4A0141D251000CCAB3D /* Valid_Example_ProjectViewController.m in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		8C00F4A4141D251100CCAB3D /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				8C00F4B9141D251100CCAB3D /* Valid_Example_ProjectTests.m in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		8C00F4CB141D3DD500CCAB3D /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				8C00F4CD141D3DD500CCAB3D /* Valid_Example_ProjectAppDelegate.m in Sources */,
				8C00F4CE141D3DD500CCAB3D /* Valid_Example_ProjectViewController.m in Sources */,
				8C00F4F2141D3E3E00CCAB3D /* main.m in Sources */,
				8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		8C00F4DE141D3DFA00CCAB3D /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				8C00F4E0141D3DFA00CCAB3D /* Valid_Example_ProjectAppDelegate.m in Sources */,
				8C00F4E1141D3DFA00CCAB3D /* Valid_Example_ProjectViewController.m in Sources */,
				8C00F4F4141D3E4F00CCAB3D /* main.m in Sources */,
				8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      
      it "should have the expected build phases" do
        @project.sources_build_phases.length.must_equal 4
      end
    end

    describe "target dependencies" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
/* Begin PBXTargetDependency section */
		8C00F4AE141D251100CCAB3D /* PBXTargetDependency */ = {
			isa = PBXTargetDependency;
			target = 8C00F484141D251000CCAB3D /* Valid Example Project */;
			targetProxy = 8C00F4AD141D251100CCAB3D /* PBXContainerItemProxy */;
		};
/* End PBXTargetDependency section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      
      it "should have the expected dependencies" do
        @project.target_dependencies.length.must_equal 1
      end
    end

    describe "variant groups" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
/* Begin PBXVariantGroup section */
		8C00F492141D251000CCAB3D /* InfoPlist.strings */ = {
			isa = PBXVariantGroup;
			children = (
				8C00F493141D251000CCAB3D /* en */,
			);
			name = InfoPlist.strings;
			sourceTree = "<group>";
		};
		8C00F49B141D251000CCAB3D /* MainWindow.xib */ = {
			isa = PBXVariantGroup;
			children = (
				8C00F49C141D251000CCAB3D /* en */,
			);
			name = MainWindow.xib;
			sourceTree = "<group>";
		};
		8C00F4A1141D251000CCAB3D /* Valid_Example_ProjectViewController.xib */ = {
			isa = PBXVariantGroup;
			children = (
				8C00F4A2141D251000CCAB3D /* en */,
			);
			name = Valid_Example_ProjectViewController.xib;
			sourceTree = "<group>";
		};
		8C00F4B2141D251100CCAB3D /* InfoPlist.strings */ = {
			isa = PBXVariantGroup;
			children = (
				8C00F4B3141D251100CCAB3D /* en */,
			);
			name = InfoPlist.strings;
			sourceTree = "<group>";
		};
/* End PBXVariantGroup section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      
      it "should have the expected variant groups" do
        @project.variant_groups.length.must_equal 4
      end
    end

    describe "build configurations" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
/* Begin XCBuildConfiguration section */
		8C00F4BA141D251100CCAB3D /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ARCHS = "$(ARCHS_STANDARD_32_BIT)";
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				GCC_C_LANGUAGE_STANDARD = gnu99;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = DEBUG;
				GCC_SYMBOLS_PRIVATE_EXTERN = NO;
				GCC_VERSION = com.apple.compilers.llvmgcc42;
				GCC_WARN_ABOUT_RETURN_TYPE = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 4.3;
				SDKROOT = iphoneos;
			};
			name = Debug;
		};
		8C00F4BB141D251100CCAB3D /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ARCHS = "$(ARCHS_STANDARD_32_BIT)";
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				GCC_C_LANGUAGE_STANDARD = gnu99;
				GCC_VERSION = com.apple.compilers.llvmgcc42;
				GCC_WARN_ABOUT_RETURN_TYPE = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 4.3;
				OTHER_CFLAGS = "-DNS_BLOCK_ASSERTIONS=1";
				SDKROOT = iphoneos;
			};
			name = Release;
		};
		8C00F4BD141D251100CCAB3D /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				COPY_PHASE_STRIP = NO;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_PRECOMPILE_PREFIX_HEADER = YES;
				GCC_PREFIX_HEADER = "Valid Example Project/Valid Example Project-Prefix.pch";
				INFOPLIST_FILE = "Valid Example Project/Valid Example Project-Info.plist";
				PRODUCT_NAME = "$(TARGET_NAME)";
				WRAPPER_EXTENSION = app;
			};
			name = Debug;
		};
		8C00F4BE141D251100CCAB3D /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				COPY_PHASE_STRIP = YES;
				GCC_PRECOMPILE_PREFIX_HEADER = YES;
				GCC_PREFIX_HEADER = "Valid Example Project/Valid Example Project-Prefix.pch";
				INFOPLIST_FILE = "Valid Example Project/Valid Example Project-Info.plist";
				PRODUCT_NAME = "$(TARGET_NAME)";
				VALIDATE_PRODUCT = YES;
				WRAPPER_EXTENSION = app;
			};
			name = Release;
		};
		8C00F4C0141D251100CCAB3D /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				BUNDLE_LOADER = "$(BUILT_PRODUCTS_DIR)/Valid Example Project.app/Valid Example Project";
				FRAMEWORK_SEARCH_PATHS = (
					"$(SDKROOT)/Developer/Library/Frameworks",
					"$(DEVELOPER_LIBRARY_DIR)/Frameworks",
				);
				GCC_PRECOMPILE_PREFIX_HEADER = YES;
				GCC_PREFIX_HEADER = "Valid Example ProjectTests/Valid Example ProjectTests-Prefix.pch";
				INFOPLIST_FILE = "Valid Example ProjectTests/Valid Example ProjectTests-Info.plist";
				OTHER_LDFLAGS = (
					"-framework",
					SenTestingKit,
				);
				PRODUCT_NAME = "$(TARGET_NAME)";
				TEST_HOST = "$(BUNDLE_LOADER)";
				WRAPPER_EXTENSION = octest;
			};
			name = Debug;
		};
		8C00F4C1141D251100CCAB3D /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				BUNDLE_LOADER = "$(BUILT_PRODUCTS_DIR)/Valid Example Project.app/Valid Example Project";
				FRAMEWORK_SEARCH_PATHS = (
					"$(SDKROOT)/Developer/Library/Frameworks",
					"$(DEVELOPER_LIBRARY_DIR)/Frameworks",
				);
				GCC_PRECOMPILE_PREFIX_HEADER = YES;
				GCC_PREFIX_HEADER = "Valid Example ProjectTests/Valid Example ProjectTests-Prefix.pch";
				INFOPLIST_FILE = "Valid Example ProjectTests/Valid Example ProjectTests-Info.plist";
				OTHER_LDFLAGS = (
					"-framework",
					SenTestingKit,
				);
				PRODUCT_NAME = "$(TARGET_NAME)";
				TEST_HOST = "$(BUNDLE_LOADER)";
				WRAPPER_EXTENSION = octest;
			};
			name = Release;
		};
		8C00F4D8141D3DD500CCAB3D /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				COPY_PHASE_STRIP = NO;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_PRECOMPILE_PREFIX_HEADER = YES;
				GCC_PREFIX_HEADER = "Valid Example Project/Valid Example Project-Prefix.pch";
				INFOPLIST_FILE = "Valid Example Project/Valid Example Project-Info.plist";
				PRODUCT_NAME = "Valid Example Project copy";
				WRAPPER_EXTENSION = app;
			};
			name = Debug;
		};
		8C00F4D9141D3DD500CCAB3D /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				COPY_PHASE_STRIP = YES;
				GCC_PRECOMPILE_PREFIX_HEADER = YES;
				GCC_PREFIX_HEADER = "Valid Example Project/Valid Example Project-Prefix.pch";
				INFOPLIST_FILE = "Valid Example Project/Valid Example Project-Info.plist";
				PRODUCT_NAME = "Valid Example Project copy";
				VALIDATE_PRODUCT = YES;
				WRAPPER_EXTENSION = app;
			};
			name = Release;
		};
		8C00F4EB141D3DFA00CCAB3D /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				COPY_PHASE_STRIP = NO;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_PRECOMPILE_PREFIX_HEADER = YES;
				GCC_PREFIX_HEADER = "Valid Example Project/Valid Example Project-Prefix.pch";
				INFOPLIST_FILE = "Valid Example Project/Valid Example Project-Info.plist";
				PRODUCT_NAME = "Valid Example Project copy";
				WRAPPER_EXTENSION = app;
			};
			name = Debug;
		};
		8C00F4EC141D3DFA00CCAB3D /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				COPY_PHASE_STRIP = YES;
				GCC_PRECOMPILE_PREFIX_HEADER = YES;
				GCC_PREFIX_HEADER = "Valid Example Project/Valid Example Project-Prefix.pch";
				INFOPLIST_FILE = "Valid Example Project/Valid Example Project-Info.plist";
				PRODUCT_NAME = "Valid Example Project copy";
				VALIDATE_PRODUCT = YES;
				WRAPPER_EXTENSION = app;
			};
			name = Release;
		};
/* End XCBuildConfiguration section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      
      it "should have the expected build configurations" do
        @project.build_configurations.length.must_equal 10
      end
    end

    describe "configuration lists" do
      before do
        content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  objects = {
/* Begin XCConfigurationList section */
		8C00F47F141D251000CCAB3D /* Build configuration list for PBXProject "Valid Example Project" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				8C00F4BA141D251100CCAB3D /* Debug */,
				8C00F4BB141D251100CCAB3D /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		8C00F4BC141D251100CCAB3D /* Build configuration list for PBXNativeTarget "Valid Example Project" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				8C00F4BD141D251100CCAB3D /* Debug */,
				8C00F4BE141D251100CCAB3D /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		8C00F4BF141D251100CCAB3D /* Build configuration list for PBXNativeTarget "Valid Example ProjectTests" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				8C00F4C0141D251100CCAB3D /* Debug */,
				8C00F4C1141D251100CCAB3D /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		8C00F4D7141D3DD500CCAB3D /* Build configuration list for PBXNativeTarget "Valid Example Project Tests" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				8C00F4D8141D3DD500CCAB3D /* Debug */,
				8C00F4D9141D3DD500CCAB3D /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		8C00F4EA141D3DFA00CCAB3D /* Build configuration list for PBXNativeTarget "Valid Example Project Specs" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				8C00F4EB141D3DFA00CCAB3D /* Debug */,
				8C00F4EC141D3DFA00CCAB3D /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
  };
}
END_PBXPROJ_CONTENT
        @project = Parser.parse(content)
        @project.must_be_instance_of Pbxproj::PbxProject
      end
      
      it "should have the expected configurations lists" do
        @project.configuration_lists.length.must_equal 5
      end
    end
  end
  
  describe "top level attributes" do
    before do
      content = <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$!
{
  archiveVersion = 1;
	classes = {
	};
	objectVersion = 46;
  objects = {
  };
  rootObject = 8C00F47C141D251000CCAB3D /* Project object */;
}
END_PBXPROJ_CONTENT
      @project = Parser.parse(content)
      @project.must_be_instance_of Pbxproj::PbxProject
    end
  end
end