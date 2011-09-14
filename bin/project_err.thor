#!/usr/bin/env ruby
require "rubygems" # ruby1.9 doesn't "require" it though
require "thor"

class ProjectErr < Thor
  desc "print FILE", "prints the structure of a project(.pbxproj) file"
  def print(project_file)
  end
  
  desc "validate FILE", "validates the structure of a project(.pbxproj) file"
  def validate(project_file)
  end
  
  desc "sort_groups FILE", "sort the groups and resources in a project(.pbxproj) file"
  def sort_groups(project_file)
  end
  
  desc "sort_resources FILE [--targets TARGETS]", "sort the resources build phases in a project(.pbxproj) file"
  method_option :targets, :type => :array, :aliases => "-t", :desc =>"Specify the targets whose resources build phases should be sorted"
  def sort_resources(project_file)
  end
  
  desc "sort_sources FILE [--targets TARGETS]", "sort the sources build phases in a project(.pbxproj) file"
  method_option :targets, :type => :array, :aliases => "-t", :desc =>"Specify the targets whose sources build phases should be sorted"
  def sort_sources(project_file)
  end
  
  desc "sort FILE", "sort groups, resources, and build phases in a project(.pbxproj) file"
  def sort(project_file)
  end
end

ProjectErr.start