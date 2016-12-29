require 'test_helper'


class TargetLifeCheckCommandTest < ActiveSupport::TestCase
  test 'should contain 1 more diagnostic' do
    # given
    targetLifeCheckCommand = get_default_command
    diagnosticCount = Diagnostic.count

    # when
    targetLifeCheckCommand.execute

    # then
    newDiagnosticCount = Diagnostic.count - diagnosticCount
    assert_equal 1, newDiagnosticCount
  end

  test 'should timeout' do
    # given
    get_default_command
    assert_equal 1, 2
  end

  def get_default_command
    target = Target.new life_url: 'https://www.google.fr', timeout: 5
    target.save
    targetLifeCheckCommand = TargetLifeCheckCommand.new(target)
  end
end