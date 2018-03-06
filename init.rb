require 'rubygems'

require 'dm-core'
require 'dm-migrations'
require 'dm-postgres-adapter'
require 'dm-validations'
require 'haml'
require 'sinatra'

configure { set :server, :puma }

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://tgl:spam42@localhost/eight_sections_development')

require './models/enrollment_fact'

DataMapper.finalize
DataMapper.auto_upgrade!

