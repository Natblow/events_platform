class EventReminderTask
  include Delayed::RecurringJob
  # run_every 5.minute
  run_every 1.day
  run_at '8:00am'
  timezone 'America/New_York'

  def perform
    AttendeeMailer.remind_event_attendees #.deliver!
  end
end
