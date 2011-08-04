begin
  # Rspec 2.0
  require 'rspec/core/rake_task'

  desc 'Default: run specs'
  task :default => :spec  
  RSpec::Core::RakeTask.new do |t|
    t.pattern = "spec/**/*_spec.rb"
  end
  
  RSpec::Core::RakeTask.new('rcov') do |t|
    t.pattern = "spec/**/*_spec.rb"
    t.rcov = true
    t.rcov_opts = ['--exclude', 'spec']
  end

rescue LoadError
  puts "Rspec not available. Install it with: gem install rspec"  
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "google_pagerank"
    gemspec.summary = "API for fetching Google Pagerank"
    gemspec.description = "API for fetching Google Pagerank"
    gemspec.email = "sebastian@agiley.se"
    gemspec.homepage = "http://github.com/Agiley/google_pagerank"
    gemspec.authors = ["Sebastian Johnsson"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler -s http://gemcutter.org"
end

#require 'bundler'
#Bundler::GemHelper.install_tasks
