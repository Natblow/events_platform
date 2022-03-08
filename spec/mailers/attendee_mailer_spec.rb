require 'rails_helper'
require 'spec_helper'

describe 'Mail Sender' do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  it 'sends email to event creator' do
    expect(AttendeeMailer).to send_email(:notify_event_creator)

    email = 'eventcreator@test.com'

    AttendeeMailer.notify_event_creator(email)
  end

  it 'sends reminder email to attendees' do
    expect(AttendeeMailer).to send_email(:event_reminder)

    email = 'eventattendee@test.com'

    AttendeeMailer.event_reminder(email)
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end
end
