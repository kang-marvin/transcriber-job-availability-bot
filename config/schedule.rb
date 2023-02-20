# env :PATH, ENV['PATH']

set :environment, "development"

set :output, "./log/cron.log"

every 5.minutes do
  command "cd #{path} && ./run.sh"
end