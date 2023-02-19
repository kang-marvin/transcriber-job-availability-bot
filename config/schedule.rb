# env :PATH, ENV['PATH']

set :environment, "development"

set :output, "./log/cron.log"

every 1.minute do
  command "cd #{path} && ./run.sh"
end