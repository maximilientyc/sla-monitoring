class TargetLifeCheckCommand

  def initialize(target)
    @target = target
  end

  def execute
    response = Typhoeus.get @target.life_url, timeout: @target.timeout
    responseWrapper = build_response_wrapper response
    Diagnostic.create responseWrapper
  end

  def build_response_wrapper(response)
    resolved = response.return_code != :couldnt_resolve_host
    connected = resolved && (response.return_code != :couldnt_connect)
    {
        target_id: @target.id,
        resolved: resolved,
        resolved_at: response.namelookup_time,
        connected: connected,
        connected_at: response.connect_time,
        total_time: response.total_time,
        status: response.response_code,
        size: response.response_body.length,
        error_details: response.return_message
    }
  end
end