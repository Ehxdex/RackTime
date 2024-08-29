class App
  def call(env)
    request = Rack::Request.new(env)
    time_formatting = TimeFormatting.new(request).check_request
    Rack::Response.new(time_formatting[:body], time_formatting[:status]).finish
  end
end
