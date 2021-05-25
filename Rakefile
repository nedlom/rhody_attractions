require "bundler/gem_tasks"
task :default => :spec

task :environment do
  require_relative './lib/rhody_attractions.rb'
end

desc 'drop into the Pry console'
task :console => :environment do
  Pry.start
end