require 'rack'
require_relative 'time_format'
require_relative 'app'

urls = {
  '/time' => App.new
}

use Rack::ContentType, 'text/plain'
run Rack::URLMap.new(urls)
