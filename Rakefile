require 'application'

require 'rake'
require 'spec/rake/spectask'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
end

namespace :db do
  desc "Setup database"
  task :setup => [:reset, :seed]
  
  desc "Add seed values to the database"
  task :seed do
    puts "Adding seed values"
    eval(File.read(File.join(Application::ROOT, "db", "seed.rb")))
  end
  
  desc "Clear all database values"
  task :reset do
    puts "Clearing All Data"
    # Do something to clear all data from databases
    puts "WARNING: Doing nothing"
  end
end
