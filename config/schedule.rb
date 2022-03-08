# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# require File.join(File.dirname(__FILE__), '/environments')

set :environments, :development

every 1.day, :at => '8:00 am' do
  runner "AttendeeMailer.event_reminder"
end
#
# every 1.minute do
#   runner "AttendeeMailer.emailing_test"
# end

# every 1.day, :at => (Event.last.time - 1.day).strftime('%I:%M %P') do
#   runner "AttendeeMailer.event_reminder"
# end
# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
