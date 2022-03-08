require 'rails_helper'

# Rails.application.load_tasks

describe "rake recurring:init", type: :task do
    it "runs rake task every day at 8am" do
      task.invoke
    end
end

# def run_task(recurring:)
#   Rake::Task["recurring:init"].invoke
# end
