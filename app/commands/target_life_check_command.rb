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
    resolved = response.options[:return_code] != :couldnt_resolve_host
    connected = resolved && (response.options[:return_code] != :couldnt_connect)
    {
        target_id: @target.id,
        resolved: resolved,
        resolved_at: response.options[:namelookup_time],
        connected: connected,
        connected_at: response.options[:connect_time],
        total_time: response.options[:total_time],
        status: response.options[:response_code],
        size: response.options[:response_body].length,
        error_details: response.options[:return_message]
    }
  end
end