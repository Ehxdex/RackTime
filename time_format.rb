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

  def check_time_format
    split_request = @req.params['format'].split(',')
    split_request.each do |element|
      TIME_FORMATS[element].nil? ? @incorrect_elements << element : @correct_elements << TIME_FORMATS[element]
    end
  end

  def format_time
    Time.now.strftime(@correct_elements.join('-'))
  end

  def correct?
    @incorrect_elements.empty?
  end

  def incorrect
    @incorrect_elements.join(', ')
  end
end
