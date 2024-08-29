class TimeFormatting
  TIME_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'}.freeze

  def initialize(req)
    @req = req
    @correct_elements = []
    @incorrect_elements = []
  end

  def check_request
    @req.params['format'] ? check_time_format : { status: 200, body: 'Time format request is empty' }
  end

  def check_time_format
    split_request = @req.params['format'].split(',')
    split_request.each do |element|
      TIME_FORMATS[element].nil? ? @incorrect_elements << element : @correct_elements << TIME_FORMATS[element]
    end
    @incorrect_elements.empty? ? { status: 200, body: Time.now.strftime(@correct_elements.join('-')) } : { status: 401, body: "Unknown time format [#{@incorrect_elements.join(',')}]" }
  end
end
