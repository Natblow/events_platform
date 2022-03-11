# Events Platform - MTL Events

You may have used some kind of event planning application on the internet, whether it's Meetup.com, Eventbrite or even Google calendar. This app has the same purpose and features.

### With Rails 6.1 + Ruby 3.0.2

## App Functionalities :

### Users Management

-  The app have user accounts with password-protected logins. It is using the **Devise gem** to manage these accounts.

- All user accounts is email verified.

-  Passwords are stored encrypted in the database.

#### 3 Levels of permissions

-  User accounts have three levels of permissions. It is using the **CanCanCan gem** manage permissions.

`app\models\ability.rb`
```ruby
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :create, :read, :update, :destroy, to: :crud

    if user.admin?
      can :manage, :all
    else
      can :crud, Event, user_id: user.id
      can :read, :all
    end
  end
end
```

- Site admins have access to the admin section of the site and all other pages/resources.

- Regular users have access to view events but cannot manage an event they haven't created, and can't view admin pages.

-  Event creators have regular user permissions, plus the ability to manage events they created. They are actually just regular users who have created an event.

### Events

#### All Events have the following fields and associated resources :

- a creator_id specifying the User record that created the event.

- a location from Mapbox's location API.

- an event time, stored as a datetime object.

- a description field written by the event creator, stored as a text value.

- an image field to illustrate the event. With the help of `Carrierwave gem`

`app\uploaders\image_uploader.rb`
```ruby
class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    # For Rails 3.1+ asset pipeline compatibility:
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "event.png"].compact.join('_'))
	  
  end

  process resize_to_fit: [440, 275]

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [240, 150]
    def default_url
      ActionController::Base.helpers.asset_path("fallback/" + [version_name, "event.png"].compact.join('_'))
    end
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end
end
```

- Event pages display the event's time, its description, a list of people who have RSVPed, a map showing the location of the event (generated using  Mapbox API), and an RSVP button.

- For the event's creator, it also show an edit button.

### RSVPs

- Any user is be able to RSVP to an event by clicking on the "Attend Now" button on an event page while logged in.

- Clicking on an RSVP button while not logged  redirect the user to the login page, then create the RSVP if the login was successful, and redirect back to the event page after that.

`app\controllers\attendees_controller.rb`
```ruby
def create
    if !current_user
     session[:creating_attendee] = true
     redirect_to user_session_path
   else
	...

```
`app\controllers\users\sessions_controller.rb`
```ruby
protected

  def after_sign_in_path_for(resource_or_scope)
    if session[:creating_attendee]
      redirect_to_event
    else
      super
    end
  end

```
`app\controllers\events_controller.rb` with `Repost` gem
```ruby
before_action :attendee?, only: :show

private

	def attendee?
      if session[:login_successful_for_attend]
        session[:login_successful_for_attend] = nil
        repost(attendee_event_path, options: {authenticity_token: :auto})
      end
    end

```

- When an RSVP is created, the event creator is notified.
`app\controllers\attendees_controller.rb`
```ruby
AttendeeMailer.with(event: @attendee).notify_event_creator.deliver_now

```

- Email notifications is sent to all users who RSVPed to an event, one day before the event takes place. It is using delay_job_recurring to run this task everyday 
`lib\tasks\recurring_jobs.rake`
```ruby
namespace :recurring do
  task init: :environment do
    EventReminderTask.schedule!
  end
end
```
`app\interactors\event_reminder_task.rb`
```ruby
class EventReminderTask
  include Delayed::RecurringJob
  run_every 1.day
  run_at '8:00am'
  timezone 'America/New_York'

  def perform
    AttendeeMailer.remind_event_attendees
  end
end
```
`app\mailers\attendee_mailer.rb`
```ruby
  def self.remind_event_attendees
    tomorrow_am = (Date.today + 1).in_time_zone("America/New_York").strftime('%a %d %b %Y %H:%M:%N %:z')
    tomorrow_pm = (Date.tomorrow + 1).in_time_zone("America/New_York").strftime('%a %d %b %Y %H:%M:%N %:z')
    event_tomorrow_between_am_pm = Event.where(time: tomorrow_am..tomorrow_pm)

    event_tomorrow_between_am_pm.uniq.each do |event|
      send_event_reminder(event)
    end
  end

  private

  def self.send_event_reminder(event)
    event.attendees.each do |attendee|
        event_reminder(attendee.user.email, event).deliver_now
    end
  end

  def event_reminder(email, event)
    @event = event
    mail(bcc: email, subject: "[Reminder] The event is tomorrow!")
  end
```

##### Tests

For testing, it is using Rspec.

Just run `Rspec spec` on the command line and we will have the tests report with 0 failures.
