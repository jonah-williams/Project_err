require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))
require File.expand_path(File.join('..', 'lib/pbxproj_nodes.rb'), File.dirname(__FILE__))

class PbxMerge
  attr_accessor :merged, :conflicts
  
  def initialize(lists)
    @merged = []
    @conflicts = []
    
    local_matches = branch_matches lists[:local], lists[:base]
    remote_matches = branch_matches lists[:remote], lists[:base]
    partners = []
    
  end
  
  private
  
  def branch_matches(branch, base)
    matches = []
    branch.each do |node|
      base_index = base.index {|base_node| base_node.content_match? node}
      if base_index
        base_node = base[base_index]
        match_type = :updated
        match_type = :unchanged if node == base_node
        matches << {:branch_node => node, :base_node => base_node, :type => match_type}
      else
        matches << {:branch_node => node, :base_node => nil, :type => :inserted}
      end
    end
    base.each do |base_node|
      match_index = local_matches.index {|node| node.content_match? base_node}
      unless match_index
        matches << {:branch_node => nil, :base_node => base_node, :type => :deleted}
      end
    end
    matches
  end
end

describe PbxMerge do
  before do
    @header = <<'END_PBXPROJ_CONTENT'
{
  objects = {
END_PBXPROJ_CONTENT

    @content = <<'END_PBXPROJ_CONTENT'
    8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F5141D3E8400CCAB3D /* ExampleSpec.m */; };
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT

    @footer = <<'END_PBXPROJ_CONTENT'
  };
}
END_PBXPROJ_CONTENT

    @base_content = '' + @header + @content + @footer
    @base = Parser.parse(@base_content).build_files
  end
  
  describe "objects unchanged in local and unchanged in remote" do
    before do
      @local = Parser.parse(@base_content).build_files
      @remote = Parser.parse(@base_content).build_files
    end
    it "takes the local version" do
      skip "merge behavior pending"
      merge = PbxMerge.new(:base => @base, :local => @local, :remote => @remote)
      merge.merged.must_equal @local
      merge.conflicts.wont_equal nil
    end
  end
  
  describe "objects unchanged in local and deleted in remote" do
    before do
      @local = Parser.parse(@base_content).build_files
      @remote_content = '' + @header
      @remote_content << <<'END_PBXPROJ_CONTENT'
    8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F5141D3E8400CCAB3D /* ExampleSpec.m */; };
END_PBXPROJ_CONTENT
      @remote_content << @footer
      @remote = Parser.parse(@remote_content).build_files
    end
    it "deletes the object" do
      skip "merge behavior pending"
      merge = PbxMerge.new(:base => @base, :local => @local, :remote => @remote)
      merge.merged.must_equal @remote
      merge.conflicts.wont_equal nil
    end
  end

  describe "objects unchanged in local and changed in remote" do
    before do
      @local = Parser.parse(@base_content).build_files
      @remote_content = '' + @header
      @remote_content << <<'END_PBXPROJ_CONTENT'
    8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F5141D3E8400CCAB3D /* ExampleSpec.m */; };
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = F33DF00DF33DF00DF33DF00D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @remote_content << @footer
      @remote = Parser.parse(@remote_content).build_files
    end
    it "takes the remote version" do
      skip "merge behavior pending"
      merge = PbxMerge.new(:base => @base, :local => @local, :remote => @remote)
      merge.merged.must_equal @remote
      merge.conflicts.wont_equal nil
    end
  end

  describe "objects deleted in local and unchanged in remote" do
    before do
      @local_content = '' + @header
      @local_content << <<'END_PBXPROJ_CONTENT'
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @local_content << @footer
      @local = Parser.parse(@local_content).build_files
      @remote = Parser.parse(@base_content).build_files
    end
    it "deletes the object" do
      skip "merge behavior pending"
      merge = PbxMerge.new(:base => @base, :local => @local, :remote => @remote)
      merge.merged.must_equal @local
      merge.conflicts.wont_equal nil
    end
  end

  describe "objects deleted in local and deleted in remote" do
    before do
      @content = '' + @header + @footer
      @local = Parser.parse(@content).build_files
      @remote = Parser.parse(@content).build_files
    end
    it "deletes the object" do
      skip "merge behavior pending"
      merge = PbxMerge.new(:base => @base, :local => @local, :remote => @remote)
      merge.merged.must_equal @local
      merge.conflicts.wont_equal nil
    end
  end

  describe "objects deleted in local and changed in remote" do
    before do
      @local_content = '' + @header
      @local_content << <<'END_PBXPROJ_CONTENT'
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @local_content << @footer
      @local = Parser.parse(@local_content).build_files
      
      @remote_content = '' + @header
      @remote_content << <<'END_PBXPROJ_CONTENT'
    8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F5141D3E8400CCAB3D /* ExampleSpec.m */; };
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = F33DF00DF33DF00DF33DF00D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @remote_content << @footer
      @remote = Parser.parse(@remote_content).build_files
    end
    it "reports a conflict" do
      skip "merge behavior pending"
      merge = PbxMerge.new(:base => @base, :local => @local, :remote => @remote)
      merge.conflicts.wont_equal(nil) && merge.conflicts.length.wont_equal(0)
    end
  end

  describe "objects changed in local and unchanged in remote" do
    before do
      @local_content = '' + @header
      @local_content << <<'END_PBXPROJ_CONTENT'
    8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F5141D3E8400CCAB3D /* ExampleSpec.m */; };
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = F33DF00DF33DF00DF33DF00D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @local_content << @footer
      @local = Parser.parse(@local_content).build_files
      @remote = Parser.parse(@base_content).build_files
    end
    it "takes the local version" do
      skip "merge behavior pending"
      merge = PbxMerge.new(:base => @base, :local => @local, :remote => @remote)
      merge.merged.must_equal @local
      merge.conflicts.wont_equal nil
    end
  end

  describe "objects changed in local and deleted in remote" do
    before do
      @local_content = '' + @header
      @local_content << <<'END_PBXPROJ_CONTENT'
    8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = F33DF00DF33DF00DF33DF00D /* ExampleSpec.m */; };
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @local_content << @footer
      @local = Parser.parse(@local_content).build_files
      
      @remote_content = '' + @header
      @remote_content << <<'END_PBXPROJ_CONTENT'
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @remote_content << @footer
      @remote = Parser.parse(@remote_content).build_files
    end
    it "reports a conflict" do
      skip "merge behavior pending"
      merge = PbxMerge.new(:base => @base, :local => @local, :remote => @remote)
      merge.conflicts.wont_equal(nil) && merge.conflicts.length.wont_equal(0)
    end
  end

  describe "objects changed in local and changed in remote" do
    before do
      @local_content = '' + @header
      @local_content << <<'END_PBXPROJ_CONTENT'
    8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = F33DF00DF33DF00DF33DF00D /* ExampleSpec.m */; };
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @local_content << @footer
      @local = Parser.parse(@local_content).build_files
      
      @remote_content = '' + @header
      @remote_content << <<'END_PBXPROJ_CONTENT'
    8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = D34DB33FD34DB33FD34DB33F /* ExampleSpec.m */; };
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @remote_content << @footer
      @remote = Parser.parse(@remote_content).build_files
    end
    it "reports a conflict" do
      skip "merge behavior pending"
      merge = PbxMerge.new(:base => @base, :local => @local, :remote => @remote)
      merge.conflicts.wont_equal(nil) && merge.conflicts.length.wont_equal(0)
    end
  end
  
  describe "objects added in local and objects added in remote" do
    before do
      @local_content = '' + @header
      @local_content << <<'END_PBXPROJ_CONTENT'
		8C992EE8137B6E7B00DD2CA7 /* ProjectCrayonsAppDelegate.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ProjectCrayonsAppDelegate.h; sourceTree = "<group>"; };
    8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F5141D3E8400CCAB3D /* ExampleSpec.m */; };
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @local_content << @footer
      @local = Parser.parse(@local_content).build_files
      
      @remote_content = '' + @header
      @remote_content << <<'END_PBXPROJ_CONTENT'
		8C992EE9137B6E7B00DD2CA7 /* ProjectCrayonsAppDelegate.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = ProjectCrayonsAppDelegate.m; sourceTree = "<group>"; };
    8C00F4F6141D3E8400CCAB3D /* ExampleSpec.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F5141D3E8400CCAB3D /* ExampleSpec.m */; };
    8C00F4F8141D3E9B00CCAB3D /* ExampleTest.m in Sources */ = {isa = PBXBuildFile; fileRef = 8C00F4F7141D3E9B00CCAB3D /* ExampleTest.m */; };
END_PBXPROJ_CONTENT
      @remote_content << @footer
      @remote = Parser.parse(@remote_content).build_files
    end
    it "takes all new objects" do
      skip "merge behavior pending"
      merge = PbxMerge.new(:base => @base, :local => @local, :remote => @remote)
      merge.merged.length.must_equal 4
      merge.conflicts.wont_equal nil
    end
  end
  
  describe "multiple changes" do
    it "merges the changes" do
      skip "merge behavior pending"
    end
  end
end
