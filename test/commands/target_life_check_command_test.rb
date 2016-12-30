require 'test_helper'

class TargetLifeCheckCommandTest < ActiveSupport::TestCase
  STUB_URL = 'http://www.stub.com/'

  test 'should contain 1 more diagnostic' do
    # given
    target = Target.create life_url: 'https://www.dumpwebsite.fr/', timeout: 5
    targetLifeCheckCommand = TargetLifeCheckCommand.new target
    diagnosticCount = Diagnostic.count

    # when
    targetLifeCheckCommand.execute

    # then
    newDiagnosticCount = Diagnostic.count - diagnosticCount
    assert_equal 1, newDiagnosticCount
  end

  test 'should be resolved and connected and successfully retreived' do
    # given
    mock_response_parameters = mock_response_parameters({resolved: true, connected: true})
    response = Typhoeus::Response.new(mock_response_parameters)
    Typhoeus.stub(STUB_URL).and_return(response)

    # when
    target = Target.create life_url: STUB_URL, timeout: 5
    targetLifeCheckCommand = TargetLifeCheckCommand.new target
    diagnostic = targetLifeCheckCommand.execute

    # then
    assert_equal diagnostic.connected?, true
    assert_equal diagnostic.resolved?, true
    assert_equal diagnostic.status, 200
  end

  test 'should not be resolved' do
    # given
    response = Typhoeus::Response.new(mock_response_parameters({resolved: false, connected: false}))
    Typhoeus.stub(STUB_URL).and_return(response)

    # when
    target = Target.create life_url: STUB_URL, timeout: 5
    targetLifeCheckCommand = TargetLifeCheckCommand.new(target)
    diagnostic = targetLifeCheckCommand.execute

    # then
    assert_equal diagnostic.connected?, false
    assert_equal diagnostic.resolved?, false
    assert_equal diagnostic.status, 0
  end

  test 'should be resolved but not connected' do
    # given
    response = Typhoeus::Response.new(mock_response_parameters({resolved: true, connected: false}))
    Typhoeus.stub(STUB_URL).and_return(response)

    # when
    target = Target.create life_url: STUB_URL, timeout: 5
    targetLifeCheckCommand = TargetLifeCheckCommand.new(target)
    diagnostic = targetLifeCheckCommand.execute

    # then
    assert_equal diagnostic.connected?, false
    assert_equal diagnostic.resolved?, true
    assert_equal diagnostic.status, 0
  end

  def mock_response_parameters(args)
    resolved = args[:resolved]
    connected = args[:connected]

    if resolved && connected
      {
          return_code: :ok,
          namelookup_time: 0.09,
          connect_time: 0.12,
          total_time: 0.30,
          response_code: 200,
          response_body: 'sample body content'
      }
    elsif !resolved && !connected
      {
          return_code: :couldnt_resolve_host,
          namelookup_time: 0,
          connect_time: 0,
          total_time: 0.21,
          response_code: 0,
          response_body: ''
      }
    elsif resolved && !connected
      {
          return_code: :couldnt_connect,
          namelookup_time: 0.09,
          connect_time: 0,
          total_time: 0.15,
          response_code: 0,
          response_body: ''
      }
    end
  end
end