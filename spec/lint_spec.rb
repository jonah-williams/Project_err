require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path(File.join('..', 'lib/parser.rb'), File.dirname(__FILE__))
require File.expand_path(File.join('..', 'lib/lint.rb'), File.dirname(__FILE__))

class Factory
  def self.missing_targets; end
  def self.no_missing_targets; end
  def self.missing_files_from_spec_target; end
  def self.no_missing_files_from_spec_target; end
  def self.duplicate_file_entries; end
  def self.no_duplicate_file_entries; end
end

describe Lint do
  describe "heuristics" do
    describe "duplicate build targets" do
      it "fails when it detects duplicate build targets" do
        result = Lint.duplicate_build_targets(Factory.duplicate_build_targets)
        assert(result)
      end
      it "passes when there are no duplicate build targets" do
        result = Lint.duplicate_build_targets(Factory.no_duplicate_build_targets)
        assert(result)
      end
    end
    describe "targets don't appear in the project dictionary" do
      it "fails when it detects missing targets" do
        result = Lint.missing_targets(Factory.missing_targets)
        assert(result)
      end
      it "passes when all targets are present" do
        result = Lint.missing_targets(Factory.no_missing_targets)
        assert(!result)
      end
    end
    describe "files in a spec target missing from underlying target" do
      it "fails when it detects missing files from spec targets" do
        result = Lint.missing_files_from_spec_target(Factory.missing_files_from_spec_target)
        assert(result)
      end
      it "passes when all spec targets are present in underlying target" do
        result = Lint.missing_files_from_spec_target(Factory.no_missing_files_from_spec_target)
        assert(!result)
      end
    end
    describe "duplicate file entries" do
      it "fails when it detects duplicate files" do
        result = Lint.duplicate_file_entries(Factory.duplicate_file_entries)
        assert(result)
      end
      it "passes when duplicate files are not present" do
        result = Lint.duplicate_file_entries(Factory.no_duplicate_file_entries)
        assert(!result)
      end
    end
  end
end