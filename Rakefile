# encoding: UTF-8

require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rake'
require 'rdoc/task'
require 'rubygems/package_task'
require 'rspec/core/rake_task'

task :default => :spec

RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

RDoc::Task.new do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  rdoc.options << '-f' << 'horo'
end
