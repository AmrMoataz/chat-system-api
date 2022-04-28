# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'resque/tasks'
require 'resque/scheduler/tasks'

task 'resque:setup' => :environment
task 'Queue=* resque:work'
task 'resque:scheduler'

Rails.application.load_tasks
