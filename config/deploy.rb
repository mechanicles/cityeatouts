set :application, "cityeatouts.com"
set :repository,  "git://github.com/mechanicles/cityeatouts.git"

role :app, "digitalcodes.org"
role :web, "digitalcodes.org"
role :db, "digitalcodes.org", :primary => true


set :deploy_to, "/home/anil/public_html/#{application}"
#set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

set :port, 22

set :scm, :git

ssh_options[:paranoid] = false

set :user, 'anil'
set :runner, user
set :use_sudo, false

after "deploy", "deploy:cleanup"
