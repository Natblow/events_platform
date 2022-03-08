# require 'event_reminder_task'

namespace :recurring do
  task init: :environment do
    EventReminderTask.schedule!

    # if Rails.env.production?
    #   MyProductionOnlyTask.schedule!
    # end
  end
end
