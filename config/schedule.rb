# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# require File.join(File.dirname(__FILE__), '/environments')

set :environments, :development

every 1.day, :at => '8:00 am' do
  runner "AttendeeMailer.event_reminder"
end

# Learn more: http://github.com/javan/whenever
