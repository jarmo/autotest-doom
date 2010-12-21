require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "autotest-doom"
    gem.summary = %Q{autotest plugin for showing bloody Doom grunt when specs are failing}
    gem.description = %Q{autotest plugin for showing bloody Doom grunt when specs are failing}
    gem.email = "jarmo.p@gmail.com"
    gem.homepage = "http://github.com/jarmo/autotest-doom"
    gem.authors = ["Jarmo Pertman"]
    gem.add_development_dependency "rspec", "~> 2.3"
    gem.add_development_dependency "yard", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
