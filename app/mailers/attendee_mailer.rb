class AttendeeMailer < ApplicationMailer

  def notify_event_creator
    @attendee = params[:event]
    mail(to: @attendee.event.user.email, subject: "A new user will attend your event!")
  end

  def self.remind_event_attendees
    tomorrow_am = (Date.today + 1).in_time_zone("America/New_York").strftime('%a %d %b %Y %H:%M:%N %:z')
    tomorrow_pm = (Date.tomorrow + 1).in_time_zone("America/New_York").strftime('%a %d %b %Y %H:%M:%N %:z')
    event_tomorrow_between_am_pm = Event.where(time: tomorrow_am..tomorrow_pm)

    event_tomorrow_between_am_pm.uniq.each do |event|
      send_event_reminder(event)
    end
  end

  def self.send_event_reminder(event)
    event.attendees.each do |attendee|
        event_reminder(attendee.user.email, event).deliver
    end
  end

  def event_reminder(email, event)
    @event = event
    mail(bcc: email, subject: "[Reminder] The event is tomorrow!")
  end
end
