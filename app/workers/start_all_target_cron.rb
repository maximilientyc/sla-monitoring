class StartAllTargetCron
  include Sidekiq::Worker

  def perform(*args)
    Scheduler.run_once
  end
end