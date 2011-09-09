require 'rake/testtask'

namespace :project do
  desc "describe the project"
  task :print, [:project_file] do |task, args|
    args.with_defaults(:project_file => "project.pbxproj")
    puts "args: #{args}"
    puts "project_file: #{args.project_file}"
    full_path = File.expand_path(args.project_file)
    puts "full path: #{full_path}"
    contents = IO.read(full_path)
    
    
  end
end

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
  t.verbose = true
end

task :default do
  puts "Usage: rake project:print project_file"
  # Rake::Task["project:print"].execute
end