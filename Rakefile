require 'rake'
require 'rspec/core/rake_task'

task default: 'test:unit'

namespace :test do

  begin
    require 'kitchen/rake_tasks'
    Kitchen::RakeTasks.new
  rescue
    puts 'Unable to load Test Kitchen' unless ENV['CI']
  end

  begin
    require 'foodcritic/rake_task'
    require 'foodcritic'
    task default: [:foodcritic]
    FoodCritic::Rake::LintTask.new do |t|
      t.options = { fail_tags: %w(correctness services libraries deprecated) }
    end
  rescue LoadError
    warn 'Unable to load Foodcritic' unless ENV['CI']
  end

  begin
    require 'rubocop/rake_task'
    require 'rubocop'
    RuboCop::RakeTask.new do |task|
      task.fail_on_error = true
      task.options = %w(-D -a)
    end
  rescue LoadError
    warn 'Unable to load RuboCop' unless ENV['CI']
  end

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir.glob('**/*_spec.rb')
    t.rspec_opts = '--color -f d --fail-fast'
  end

  desc 'runs quick unit tests'
  task :unit do
    Rake::Task['test:rubocop'].invoke
    puts 'Running Foodcritic...'
    Rake::Task['test:foodcritic'].invoke
    puts 'Running RSpec...'
    Rake::Task['test:spec'].invoke
  end

  desc 'runs full test-kitchen suite'
  task :integration do
    Rake::Task['test:kitchen:all'].invoke
  end

end

namespace :release do

  desc 'Uploads the cookbook to the Chef Server'
  task :upload do
    metadata = Chef::Cookbook::Metadata.new
    metadata.from_file('metadata.rb')
    path = File.expand_path('..', File.dirname(__FILE__))
    Chef::Knife.run(['cookbook', 'upload', metadata.name, '-o', path])
  end

  namespace :promote do

    desc 'Promotes the cookbook to the development environment'
    task :development do
      metadata = Chef::Cookbook::Metadata.new
      metadata.from_file('metadata.rb')
      environment = Chef::Environment.load('development')
      environment.cookbook_versions[metadata.name] = "<= #{metadata.version}"
      environment.save
    end

    desc 'Promotes the cookbook to the systemtest environment'
    task :systemtest do
      metadata = Chef::Cookbook::Metadata.new
      metadata.from_file('metadata.rb')
      environment = Chef::Environment.load('systemtest')
      environment.cookbook_versions[metadata.name] = "<= #{metadata.version}"
      environment.save
    end

    desc 'Promotes the cookbook to the production environment'
    task :production do
      metadata = Chef::Cookbook::Metadata.new
      metadata.from_file('metadata.rb')
      environment = Chef::Environment.load('production')
      environment.cookbook_versions[metadata.name] = "<= #{metadata.version}"
      environment.save
    end

    desc 'Promotes the cookbook to all environments'
    task :all do
      Rake::Task['release:promote:development'].invoke
      Rake::Task['release:promote:systemtest'].invoke
      Rake::Task['release:promote:production'].invoke
    end

  end

end
