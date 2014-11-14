require 'rake'
require 'rspec/core/rake_task'

task default: 'test:unit'

namespace :test do

  begin
    require 'kitchen/rake_tasks'
    Kitchen::RakeTasks.new
  rescue
    puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
  end

  begin
    require 'foodcritic/rake_task'
    require 'foodcritic'
    task default: [:foodcritic]
    FoodCritic::Rake::LintTask.new do |t|
      t.options = { fail_tags: %w(correctness services libraries deprecated) }
    end
  rescue LoadError
    warn 'Foodcritic Is missing ZOMG'
  end

  begin
    require 'rubocop/rake_task'
    require 'rubocop'
    RuboCop::RakeTask.new do |task|
      task.fail_on_error = true
      task.options = %w(-D -a)
    end
  rescue LoadError
    warn 'Rubocop gem not installed, now the code will look like crap!'
  end

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir.glob('**/*_spec.rb')
    t.rspec_opts = '--color -f d --fail-fast'
  end

  task :unit do
    Rake::Task['test:rubocop']
    Rake::Task['test:foodcritic']
    Rake::Task['test:spec']
  end

  task :integration do
    Rake::Task['test:kitchen:all']
  end

end
