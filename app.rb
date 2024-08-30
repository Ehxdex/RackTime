class App
  def call(env)
    request = Rack::Request.new(env)
    @tf = TimeFormatting.new(request)
    request.params['format'] ? show_time : response('Time format request is empty', 400)
  end

  private

  def show_time
    @tf.check_time_format
    @tf.correct? ? response(@tf.format_time, 200) : response("Unknown time format[#{@tf.incorrect}]", 401)
  end

  def response(body, status)
    Rack::Response.new(body, status).finish
  end
end
