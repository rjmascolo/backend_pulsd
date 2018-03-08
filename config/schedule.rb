# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

require "./"+ File.dirname(__FILE__) + "/environment.rb"

set :output, 'log/whenever.log'

every :hour do
  runner "Event.syndicate_events" , :environment => "development"
end
