RSpec.configure do |config|
  config.before do
    Delayed::Worker.delay_jobs = false
  end
  # config.include(ActiveJob::TestHelper)
  class ActiveJob::QueueAdapters::DelayedJobAdapter
    class EnqueuedJobs
      def clear
        Delayed::Job.where(failed_at:nil).map &:destroy
      end
    end

    class PerformedJobs
      def clear
        Delayed::Job.where.not(failed_at:nil).map &:destroy
      end
    end

    def enqueued_jobs
      EnqueuedJobs.new
    end

    def performed_jobs
      PerformedJobs.new
    end
  end
end
