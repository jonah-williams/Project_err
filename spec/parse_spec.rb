require 'polyglot'
require 'treetop'
require 'minitest/spec'
require 'minitest/autorun'
 
class Parse

end

module MiniTest::Assertions
  def must_parse(content)    
    result = @parser.parse(content)
    assert result != nil, "parse error: #{@parser.failure_reason} #{@parser.failure_line} #{@parser.failure_column}\nconsumed #{@parser.index}/#{content.length} characters from:\n#{content}"
  end  
end
 
describe Parse do
  before do
    Treetop.load 'pbxproj'
    @parser = PbxprojParser.new
  end
 
  describe "comments" do
    it "parses end of line comments" do
      must_parse <<END_PBXPROJ_CONTENT
// !$*UTF8*$! /* file header */
//
END_PBXPROJ_CONTENT
    end
    
    it "parses c comments" do
      must_parse <<END_PBXPROJ_CONTENT
/* comment */
END_PBXPROJ_CONTENT
    end
    
    it "parses commented value" do
      must_parse <<END_PBXPROJ_CONTENT
{value /* comment */ = otherValue /* comment */;}
END_PBXPROJ_CONTENT
    end
  end
 
  describe "dictionaries" do
    it "parses an empty dictionary" do
      must_parse <<END_PBXPROJ_CONTENT
{} /* empty hash */
END_PBXPROJ_CONTENT
    end

    it "parses nested dictionaries" do
      must_parse <<END_PBXPROJ_CONTENT
{
  archiveVersion = 1;
  classes = {
    nestedHash = true;
  };
  objectVersion = 45;
}
END_PBXPROJ_CONTENT
    end
    
    it "parses dictionaries with string keys" do
      must_parse <<END_PBXPROJ_CONTENT
{
  "valueWithStringEscapedCharacters[foo=bar]{}--;;()" = 1;
  "value with some spaces" = 45;
}
END_PBXPROJ_CONTENT
    end
  end
  
  describe "arrays" do
    it "parses an empty array" do
      must_parse <<END_PBXPROJ_CONTENT
{
  foo = ();
}
END_PBXPROJ_CONTENT
    end
    
    it "parses an array" do
      must_parse <<END_PBXPROJ_CONTENT
{
  buildConfigurations = (
    C01FCF4F08A954540054247B /* Debug */,
    C01FCF5008A954540054247B /* Release */,
    E22E41D81281F13F006A09EA /* Distribution */,
  );
}
END_PBXPROJ_CONTENT
    end
  end
end