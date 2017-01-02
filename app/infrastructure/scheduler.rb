class Scheduler
  def self.run_once
    Target.find_each do |target|
      StartTargetWorker.perform_async target.id
    end
  end
end