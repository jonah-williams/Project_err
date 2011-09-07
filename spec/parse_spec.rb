require 'polyglot'
require 'treetop'
require 'minitest/spec'
require 'minitest/autorun'
 
class Parse

end

module MiniTest::Assertions
  def must_parse(content)
    parser = PbxprojParser.new
    result = parser.parse(content)
    assert !result, "parse error: #{parser.failure_reason} #{parser.failure_line} #{parser.failure_column}"
  end  
end
 
describe Parse do
  before do
    Treetop.load 'pbxproj'
  end
 
  describe "comments" do
    before do
      @content = <<END_PBXPROJ_CONTENT
// !$*UTF8*$! /* file header */
END_PBXPROJ_CONTENT
    end
    it "parses successfully" do
      must_parse @content 
    end
  end
 
  describe "hashes" do
    before do
      @content = <<END_PBXPROJ_CONTENT
{}; /* empty hash */
{ /* comment in hash */ };

{
  archiveVersion = 1;
  classes = {
  };
  objectVersion = 45;
};
END_PBXPROJ_CONTENT
    end
    it "parses successfully" do
      must_parse @content 
    end
  end
  
  describe "arrays" do
    before do
      @content = <<END_PBXPROJ_CONTENT
{
  buildConfigurations = (
	C01FCF4F08A954540054247B /* Debug */,
	C01FCF5008A954540054247B /* Release */,
	E22E41D81281F13F006A09EA /* Distribution */,
);
};
END_PBXPROJ_CONTENT
    end
    it "parses successfully" do
      must_parse @content
    end
  end
end