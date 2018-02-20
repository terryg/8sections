require 'rubygems'

require 'haml'
require 'sinatra'

configure { set :server, :puma }

DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, {:adapter => 'postgres'})

require './models/enrollment_fact'

DataMapper.finalize
DataMapper.auto_upgrade!

