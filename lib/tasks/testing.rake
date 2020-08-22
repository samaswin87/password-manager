desc "Runs all tests in test folder"
task :test do
  Rake::Task[:test].clear

  unless ENV['RAILS_ENV'] == 'test'
    puts "Please run with RAILS_ENV=test"
    exit
  end

  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:schema:load'].invoke
  Rake::Task[:test].invoke
end

desc "Clear test DB"
namespace :db do
  namespace :test do
    task :recreate do
      unless ENV['RAILS_ENV'] == 'test'
        puts "Please run with RAILS_ENV=test"
        exit
      end

      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:schema:load'].invoke
    end
  end
end
