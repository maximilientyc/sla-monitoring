class StartTargetWorker
  include Sidekiq::Worker

  def perform(target_id)
    target = Target.find(target_id)
    targetLifeCheckCommand = TargetLifeCheckCommand.new target
    targetLifeCheckCommand.execute
  end
end