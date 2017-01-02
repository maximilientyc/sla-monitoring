require 'test_helper'

class SchedulerTest < ActiveSupport::TestCase

  test 'sample' do
    create_sample_data
    Scheduler.run_once
  end

  def create_sample_data
    100.times do
      target = Target.create life_url: 'https://www.dumpwebsite.fr/', timeout: 5
      targetLifeCheckCommand = TargetLifeCheckCommand.new target
      targetLifeCheckCommand.execute
    end
  end
end