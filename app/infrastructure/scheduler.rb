class Scheduler
  def run_once
    Target.find_each do |target|
      # for now we create and execute a new command.
      # Next we will create an asynchronous task to be launched later
      targetLifeCheckCommand = TargetLifeCheckCommand.new target
      targetLifeCheckCommand.execute
    end
  end
end