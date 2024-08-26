class App
  def call(env)
    @query_string = env['QUERY_STRING']
    @path = env['REQUEST_PATH']
    @user_request = Rack::Utils.parse_nested_query(@query_string).values.join.split(',')
    @time_formats = %w[year month day hour minute second]
    [status, headers, body]
  end

  private

  def status
    case @path
    when '/time'
      if check_time_format
        200
      else
        400
      end
    else
      404
    end
  end

  def headers
    { 'content-type' => 'text/plain' }
  end

  def body
    case @path
    when '/time'
      if check_time_format
        [convert_user_format]
      else
        ["Unknown time format #{unknown_time_format}"]
      end
    else
      ['Wrong request, path unknown']
    end
  end

  def check_time_format
    (@user_request - @time_formats).empty?
  end

  def unknown_time_format
    @user_request - @time_formats
  end

  def convert_user_format
    @user_request.map! { |tf|
      case tf
      when 'year'
        Time.now.year
      when 'month'
        Time.now.month
      when 'day'
        Time.now.day
      when 'hour'
        Time.now.hour
      when 'minute'
        Time.now.min
      when 'second'
        Time.now.sec
      end
    }
    @user_request.join('-')
  end
end
