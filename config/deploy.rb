set :application, "stadiumchoir"
set :repository,  "set your repository location here"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/www/stadiumchoir.twoedge.com"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, "thepavedearth.com"

namespace :deploy do
  desc "Deploys the app on production."
  task :default do
    pull
    migrate
    restart
  end

  desc "for testing"
  task :ls do
    run "cd #{deploy_to}; ls"
  end

  desc "Pulls the latest from github into the production copy."
  task :pull do
    run "cd #{deploy_to}; git pull"
  end

  desc "Runs the migrations on production"
  task :migrate do
    run "cd #{deploy_to}; rake db:migrate"
  end

  desc "Restarts passenger on production."
  task :restart do
    run "cd #{deploy_to}; touch tmp/restart.txt"
  end
end
