# Testing frameworks
require "minitest/spec"
require "minitest/autorun"
require "minitest/mock"

# Debugger
require "pry"

# The gem
$: << File.dirname(__FILE__) + "/../lib"
$: << File.dirname(__FILE__)

require "konami"
