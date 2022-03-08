# spec/whenever_spec.rb
require 'whenever'
require 'rails_helper'
require 'spec_helper'

describe 'Whenever Schedule' do
  before do
    load 'Rakefile' # Makes sure rake tasks are loaded so you can assert in rake jobs
  end

  let(:schedule) do
    Whenever::Test::Schedule.new(file: 'config/schedule.rb')
  end

  it 'makes sure `runner` statements exist' do
    assert_equal 1, schedule.jobs[:runner].count
    # Executes the actual ruby statement to make sure all constants and methods exist:
    schedule.jobs[:runner].each { |job| instance_eval job[:task] }
  end

  it "sends mail to attendees everyday at 8am for events coming the next day" do
    assert_equal 'AttendeeMailer.event_reminder', schedule.jobs[:runner].first[:task]
  end

  # it 'makes sure `rake` statements exist' do
  #   # config/schedule.rb file is used by default in constructor:
  #   schedule = Whenever::Test::Schedule.new(vars: { environment: 'staging' })
  #
  #   # Makes sure the rake task is defined:
  #   assert Rake::Task.task_defined?(schedule.jobs[:rake].first[:task])
  # end
  #
  # it 'makes sure cron alive monitor is registered in minute basis' do
  #   schedule = Whenever::Test::Schedule.new(file: fixture)
  #
  #   assert_equal 'http://myapp.com/cron-alive', schedule.jobs[:curl].first[:task]
  #   assert_equal 'curl :task', schedule.jobs[:curl].first[:command]
  #   assert_equal [:minute], schedule.jobs[:curl].first[:every]
  # end
end
