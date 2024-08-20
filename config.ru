require_relative 'middleware/racktime'
require_relative 'app'

use RackTime
run App.new
