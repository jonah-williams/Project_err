require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))
require File.expand_path(File.join('..', 'lib/compiler.rb'), File.dirname(__FILE__))

describe Compiler do
  describe "commutativity" do
    it "compiling a parse tree should emit a file identical to the parser input" do
      input_pbxproj = File.read(File.expand_path('example_project.pbxproj', File.dirname(__FILE__)))
      tree = Parser.parse(input_pbxproj)
      compiled = Compiler.compile(tree)
      assert(compiled == input_pbxproj)
    end
  end
end