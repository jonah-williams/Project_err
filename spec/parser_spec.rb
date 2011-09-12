require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))

module MiniTest::Assertions
  def assert_parses(content)    
    result = Parser.parse(content)
    assert result != nil, Parser.failure
  end  
end

describe Parser do
  describe "project file" do
    it "parses an example project" do
      content = File.read(File.expand_path('example_project.pbxproj', File.dirname(__FILE__)))
      assert content != nil
      tree = Parser.parse(content)
      assert tree != nil, "should create a parse tree"
      assert tree.class.name == "Pbxproj::PbxProject", "root node should be a PbxProject"
    end
  end
  
  describe "comments" do
    it "parses end of line comments" do
      assert_parses <<'END_PBXPROJ_CONTENT'
// !$*UTF8*$! /* file header */
//
END_PBXPROJ_CONTENT
    end
    
    it "parses c comments" do
      assert_parses <<'END_PBXPROJ_CONTENT'
/* comment */
END_PBXPROJ_CONTENT
    end
    
    it "parses commented value" do
      assert_parses <<'END_PBXPROJ_CONTENT'
{value /* comment */ = otherValue /* comment */;}
END_PBXPROJ_CONTENT
    end
  end
 
  describe "dictionaries" do
    it "parses an empty dictionary" do
      assert_parses <<'END_PBXPROJ_CONTENT'
{} /* empty hash */
END_PBXPROJ_CONTENT
    end

    it "parses nested dictionaries" do
      assert_parses <<'END_PBXPROJ_CONTENT'
{
  archive/Version = 1;
  classes = {
    nestedHash = true;
  };
  object.version = 45;
}
END_PBXPROJ_CONTENT
    end
    
    it "parses dictionaries with string keys" do
      assert_parses <<'END_PBXPROJ_CONTENT'
{
  "valueWithStringEscapedCharacters[foo=bar]{}--;;()\"andStuff" = 1;
  "value with some spaces" = 45;
}
END_PBXPROJ_CONTENT
    end
  end
  
  describe "arrays" do
    it "parses an empty array" do
      assert_parses <<'END_PBXPROJ_CONTENT'
{
  foo = ();
}
END_PBXPROJ_CONTENT
    end
    
    it "parses an array" do
      assert_parses <<'END_PBXPROJ_CONTENT'
{
  buildConfigurations = (
    C01FCF4F08A954540054247B /* Debug */,
    C01FCF5008A954540054247B /* Release */,
    E22E41D81281F13F006A09EA /* Distribution */,
  );
}
END_PBXPROJ_CONTENT
    end
    
    it "parses an array containing a dictionary" do
      assert_parses <<'END_PBXPROJ_CONTENT'
{
  projectReferences = (
		{
			ProductGroup = 93531FAC12E14FB800FE8499 /* Products */;
			ProjectRef = 93531FAB12E14FB800FE8499 /* stuff.xcodeproj */;
		},
	);
}
END_PBXPROJ_CONTENT
    end
  end
end