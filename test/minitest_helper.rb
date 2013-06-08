# Testing frameworks
#require 'coveralls'
#Coveralls.wear!
require 'simplecov'
SimpleCov.start

require "minitest/autorun"

# Debugger
require "pry"

# The gem
$: << File.dirname(__FILE__) + "/../lib"
$: << File.dirname(__FILE__)

require "konamio"
